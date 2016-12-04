defmodule Webapp.RoleResolver do
  require Webapp.Mapper

  import Webapp.Mapper, only: [remap: 3]

  @mapping [
    id: ["links.roleUsers", &Webapp.RoleResolver.to_id/1],
    identifier: "meta.identifier",
    title: "meta.title",
    summary: "meta.summary"
  ]

  def to_id(url) do
    parts = String.split(url, "/")
    "#{Enum.fetch!(parts, 3)}/#{Enum.fetch!(parts, 5)}"
  end

  def all(_args, _info) do
    {:ok, []}
  end

  def find(%{id: id}, _info) do
    IO.inspect(id)
    {:ok, %{}}
  end

  def find_multiple(parent, _args, info) do
    IO.inspect(parent)
    cookies = Webapp.Helper.transform_cookies(info)

    %{source: %{id: id}} = info

    res = Poison.decode!(Webapp.Request.get("/gdc/projects/#{id}/roles", cookies).body)
    roles = Enum.map(
      get_in(res, ["projectRoles", "roles"]),
      fn(url) ->
        role = Poison.decode!(Webapp.Request.get(url, cookies).body)
        remap(role, @mapping, root: "projectRole")
      end
    )

    {:ok, roles}
  end
end
