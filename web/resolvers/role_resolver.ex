defmodule Webapp.RoleResolver do
  def all(_args, _info) do
    {:ok, []}
  end

  def find(%{id: id}, _info) do
    IO.inspect(id)
    {:ok, %{}}
  end

  def find_multiple(_args, info) do
    cookies = Webapp.Helper.transform_cookies(info)

    %{source: %{id: id}} = info

    res = Poison.decode!(Webapp.Request.get("/gdc/projects/#{id}/roles", cookies).body)
    roles = Enum.map(
      get_in(res, ["projectRoles", "roles"]),
      fn(url) ->
        role = Poison.decode!(Webapp.Request.get(url, cookies).body)
        parts = String.split(url, "/")
        %{
          id: "#{Enum.fetch!(parts, 3)}/#{Enum.fetch!(parts, 5)}",
          identifier: get_in(role, ["projectRole", "meta", "identifier"]),
          title: get_in(role, ["projectRole", "meta", "title"]),
          summary: get_in(role, ["projectRole", "meta", "summary"]),
        }
      end
    )

    {:ok, roles}
  end
end
