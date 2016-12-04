defmodule Webapp.ProjectResolver do
  require Webapp.Mapper

  import Webapp.Mapper, only: [uri_to_id: 0, remap: 3]

  @mapping [
    id: ["links.self", uri_to_id],
    url: "links.self",
    environment: "content.environment",
    driver: "content.driver",
    state: "content.state",
    title: "meta.title"
  ]

  def all(_args, info) do
    cookies = Webapp.Helper.transform_cookies(info)

    projects_cookie = String.replace(List.first(Enum.filter(cookies, fn(c) -> String.starts_with?(c, "Projects=") end)), "Projects=", "")
    res = Poison.decode!(Webapp.Request.get(projects_cookie, cookies).body)

    projects = Map.get(res, "projects")

    data = Enum.map(
      projects,
      fn(project) ->
        transform_project(project)
      end
    )

    {:ok, data}
  end

  def find(%{id: id}, info) do
    cookies = Webapp.Helper.transform_cookies(info)

    url = "/gdc/projects/#{id}"
    res = Poison.decode!(Webapp.Request.get(url, cookies).body)

    {:ok, transform_project(res)}
  end


  defp transform_project(project) do
    result = remap(project, @mapping, root: "project")
    Map.put(result, :roles, [%{id: "123"}])
  end
end
