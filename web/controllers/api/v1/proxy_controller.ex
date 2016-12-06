defmodule Webapp.API.V1.ProxyController do
  use Webapp.Web, :controller

  require Logger

  def proxy(conn, params) do
    url = "/#{Enum.join(params["path"], "/")}"

    res = Webapp.Request.get(url, conn.cookies)

    data = Poison.decode!(res.body)
    conn
    |> json(data)
  end
end
