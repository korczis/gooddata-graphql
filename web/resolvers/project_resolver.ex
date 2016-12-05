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
    updated: "meta.updated"
  ]

  def all(_args, info) do
    cookies = Webapp.Helper.transform_cookies(info)

    projects_cookie = String.replace(List.first(Enum.filter(cookies, fn(c) -> String.starts_with?(c, "Projects=") end)), "Projects=", "")
    res = Poison.decode!(Webapp.Request.get(projects_cookie, cookies).body)

    projects = Map.get(res, "projects")

    data = Enum.map(
      projects,
      fn(project) ->
        transform_project(project, cookies)
      end
    )

    {:ok, data}
  end

  def find(%{id: id}, info) do
    cookies = Webapp.Helper.transform_cookies(info)

    url = "/gdc/projects/#{id}"
    res = Poison.decode!(Webapp.Request.get(url, cookies).body)

    {:ok, transform_project(res, cookies)}
  end


  defp transform_project(project, cookies) do
    res = Poison.decode!(Webapp.Request.get(get_in(project, ["project", "links", "roles"]), cookies).body)
    roles = Enum.map(
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
