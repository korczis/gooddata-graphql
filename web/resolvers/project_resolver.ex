defmodule Webapp.ProjectResolver do
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
    url = get_in(project, ["project", "links", "self"])
    roles_url = get_in(project, ["project", "links", "roles"])
    id = Enum.fetch!(String.split(url, "/"), 3)
    %{
      id: id,
      url: url,
      environment: get_in(project, ["project", "content", "environment"]),
      driver: get_in(project, ["project", "content", "driver"]),
      state: get_in(project, ["project", "content", "state"]),
      title: get_in(project, ["project", "meta", "title"]),
      roles: [%{id: "123"}]
    }
  end
end
