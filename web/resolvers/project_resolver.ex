defmodule Webapp.ProjectResolver do
  require Webapp.Mapper

  import Webapp.Mapper, only: [uri_to_id: 0, remap: 3]

  @mapping [
    id: ["links.self", uri_to_id],
    url: "links.self",
    cluster: "content.cluster",
    driver: "content.driver",
    environment: "content.environment",
    state: "content.state",
    summary: "meta.summary",
    title: "meta.title",
    created: "meta.created",
    updated: "meta.updated",
    author: ["meta.author", uri_to_id],
    contributor: ["meta.contributor", uri_to_id],
    guided_navigation: "content.guidedNavigation",
    is_public: "content.isPublic,"
  ]

  def all(args, info) do
    cookies = info.context.cookies

    projects_cookie = Map.fetch!(cookies, "Projects")
    res = Poison.decode!(Webapp.Request.get(projects_cookie, cookies).body)

    projects = Map.get(res, "projects")

    data = Parallel.map(
      projects,
      fn(project) ->
        transform_project(project, args[:owner], args[:title], args[:driver], cookies)
      end
    )

    {:ok, Enum.filter(data, fn project -> project != nil end)}
  end

  def find(%{id: id}, info) do
    cookies = info.context.cookies

    url = "/gdc/projects/#{id}"
    res = Poison.decode!(Webapp.Request.get(url, cookies).body)

    {:ok, transform_project(res, cookies)}
  end

  defp transform_project(project, cookies) do
    transform_project(project, nil, nil, nil, cookies)
  end

  defp transform_project(project, owner, title, driver, cookies) do
    gd_project = Poison.decode!(Webapp.Request.get(get_in(project, ["project", "links", "roles"]), cookies).body)

    remap(project, @mapping, root: "project")
      |> filter_project_on_property(gd_project, owner, :author)
      |> filter_project_on_property(gd_project, title, :title)
      |> filter_project_on_property(gd_project, driver, :driver)
  end

  defp filter_project_on_property(remapped_project, gd_project, property, project_property_name) do
    project_property = remapped_project[project_property_name]
    case property do
      nil ->
        roles = do_magic_with_roles(gd_project)
        Map.put(remapped_project, :roles, roles)
      ^project_property ->
        roles = do_magic_with_roles(gd_project)
        Map.put(remapped_project, :roles, roles)
      _v -> nil
    end
  end

  defp do_magic_with_roles(gd_project) do
    Parallel.map(
      get_in(gd_project, ["projectRoles", "roles"]),
      fn(url) ->
        parts = String.split(url, "/")
        "#{Enum.fetch!(parts, 3)}/#{Enum.fetch!(parts, 5)}"
      end
    )
  end

end
