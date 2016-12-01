defmodule Webapp.API.V1.AuthController do
  use Webapp.Web, :controller

  require Logger

  def sign_in(conn, %{"email" => email, "password" => password}) do
    host = Application.get_env(:webapp, Webapp.Endpoint)[:gooddata][:host]

    res = Webapp.Request.post("/gdc/account/login", %{
      postUserLogin: %{
        login: email,
        password: password
      }
    })

    cookies = List.keyfind(res.headers, "Set-Cookie", 0)
      |> elem(1)
      |> String.replace("/gdc", "/")

    conn
    |> put_resp_header("Set-Cookie", cookies)
    |> json(Poison.decode!(res.body))
  end

  def sign_out(conn, _params) do
    conn
    |> json(%{})
  end

  def user(conn, _params) do
    conn
    |> json(%{})
  end
end
