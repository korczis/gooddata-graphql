defmodule Webapp.API.V1.ProxyController do
  use Webapp.Web, :controller

  require Logger

  def proxy(conn, params) do
    pars = Map.delete(params, "path")
    url = case Enum.count(pars) do
      0 -> "/#{Enum.join(params["path"], "/")}"
      _ -> "/#{Enum.join(params["path"], "/")}?#{URI.encode_query(pars)}"
    end

    res = Webapp.Request.get(url, conn.cookies)

    data = Poison.decode!(res.body)
    conn
    |> json(data)
  end
end
