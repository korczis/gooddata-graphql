defmodule Webapp.ProjectResolver do
  def all(_args, info) do
    cookies = String.split(List.first(Map.get(info.context, :cookies)), "; ")
    IO.inspect(cookies)

    projects_cookie = String.replace(List.first(Enum.filter(cookies, fn(c) -> String.starts_with?(c, "Projects=") end)), "Projects=", "")
    res = Poison.decode!(Webapp.Request.get(projects_cookie, cookies).body)

    projects = Map.get(res, "projects")

    data = Enum.map(
      projects,
      fn(project) ->
        id = Enum.fetch!(String.split(get_in(project, ["project", "links", "self"]), "/"), 3)
        %{
          id: id,
          title: get_in(project, ["project", "meta", "title"])
        }
      end
    )

    IO.inspect(data)

    {:ok, data}
  end
end
