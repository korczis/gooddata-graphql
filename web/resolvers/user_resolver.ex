defmodule Webapp.UserResolver do
  require Webapp.Mapper

  import Webapp.Mapper, only: [uri_to_id: 0, remap: 3]

  @mapping [
    id: ["links.self", uri_to_id],
    url: "links.self",
    email: "email",
    language: "language",
    login: "login",
    position: "position",
    timezone: "timezone",
    created: "created",
    updated: "updated",
  ]

  def find(%{id: id}, info) do
    cookies = info.context.cookies
    {:ok, get_user(id, cookies)}
  end

  def find_role_users(%{url: url}, info) do
    cookies = info.context.cookies

    res = Poison.decode!(Webapp.Request.get(url, cookies).body)
    user_urls = get_in(res, ["associatedUsers", "users"])
    users = Parallel.map(
      user_urls || [],
      fn(url) ->
        id = List.last(String.split(url, "/"))
        get_user(id, cookies)
      end
    )

    {:ok, users}
  end

  defp get_user(id, cookies) do
    user_url = "/gdc/account/profile/#{id}"
    res = Poison.decode!(Webapp.Request.get(user_url, cookies).body)
    remap(res, @mapping, root: "accountSetting")
  end
end
