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
    is_public: "content.isPublic",
  ]

  def all(_args, info) do
    cookies = info.context.cookies

    projects_cookie = Map.fetch!(cookies, "Projects")
    res = Poison.decode!(Webapp.Request.get(projects_cookie, cookies).body)

    projects = Map.get(res, "projects")

    data = Parallel.map(
      projects,
      fn(project) ->
        transform_project(project, cookies)
      end
    )

    {:ok, data}
  end

  def find(%{id: id}, info) do
    cookies = info.context.cookies

    url = "/gdc/projects/#{id}"
    res = Poison.decode!(Webapp.Request.get(url, cookies).body)

    {:ok, transform_project(res, cookies)}
  end


  defp transform_project(project, cookies) do
    res = Poison.decode!(Webapp.Request.get(get_in(project, ["project", "links", "roles"]), cookies).body)
    roles = Parallel.map(
      get_in(res, ["projectRoles", "roles"]),
      fn(url) ->
        parts = String.split(url, "/")
        "#{Enum.fetch!(parts, 3)}/#{Enum.fetch!(parts, 5)}"
      end
    )

    result = remap(project, @mapping, root: "project")
    Map.put(result, :roles, roles)
  end
end
