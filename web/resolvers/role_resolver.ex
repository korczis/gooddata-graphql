defmodule Webapp.RoleResolver do
  require Webapp.Mapper

  import Webapp.Mapper, only: [remap: 3, uri_to_id: 0]

  @mapping [
    id: ["links.roleUsers", &Webapp.RoleResolver.to_id/1],
    identifier: "meta.identifier",
    title: "meta.title",
    summary: "meta.summary",
    url: "links.self",
    author: ["meta.author", uri_to_id],
    contributor: ["meta.contributor", uri_to_id],
    created: "meta.created",
    updated: "meta.updated"
  ]

  def to_id(url) do
    parts = String.split(url, "/")
    "#{Enum.fetch!(parts, 3)}/#{Enum.fetch!(parts, 5)}"
  end

  def all(_args, _info) do
    {:ok, []}
  end

  def find(%{id: id}, info) do
    cookies = info.context.cookies

    raw_role = get_role(id, cookies)
    res = remap(raw_role, @mapping, root: "projectRole")
    role = Map.put(res, :url, get_role_url(id))

    {:ok, role}
  end

  def find_multiple(parent, _args, info) do
    cookies = info.context.cookies

    roles = Parallel.map(
      get_in(parent, [:roles]),
      fn(id) ->
        role = get_role(id, cookies)
        res = remap(role, @mapping, root: "projectRole")
        Map.put(res, :url, get_role_url(id))
      end
    )

     {:ok, roles}
  end

  defp get_role(role_id, cookies) do
    Poison.decode!(Webapp.Request.get(get_role_url(role_id), cookies).body)
  end

  defp get_role_url(role_id) do
    parts = String.split(role_id, "/")
    "/gdc/projects/#{Enum.fetch!(parts, 0)}/roles/#{Enum.fetch!(parts, 1)}"
  end
end
