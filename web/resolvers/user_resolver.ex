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

    user_url = "/gdc/account/profile/#{id}"
    res = Poison.decode!(Webapp.Request.get(user_url, cookies).body)
    user = remap(res, @mapping, root: "accountSetting")

    {:ok, user}
  end
end
