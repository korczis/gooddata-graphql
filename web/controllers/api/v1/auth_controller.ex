defmodule Webapp.API.V1.AuthController do
  use Webapp.Web, :controller

  require Logger

  def sign_in(conn, %{"email" => email, "password" => password}) do
    res = Webapp.Request.post("/gdc/account/login", %{
      postUserLogin: %{
        login: email,
        password: password
      }
    })

    conn
    |> put_cookies(res)
    |> Webapp.Helper.tt_refreshed
    |> json(Poison.decode!(res.body))
  end

  def sign_out(conn, _params) do
    conn
    |> json(%{})
  end

  def user(conn, _params) do
    data = Poison.decode!(Webapp.Request.get("/gdc/app/account/bootstrap", conn.cookies).body)
    user = get_in(data, ["bootstrapResource", "accountSetting"])
    user_url = get_in(data, ["bootstrapResource", "accountSetting", "links", "self"])
    projects_url = get_in(data, ["bootstrapResource", "accountSetting", "links", "projects"])

    case user do
      nil ->
       conn
       |> json(%{})
      _ ->
       conn
       |> put_resp_cookie("User", user_url, [{:path, "/"}])
       |> put_resp_cookie("Projects", projects_url, [{:path, "/"}])
       |> json(user)
    end
  end

  defp put_cookies(conn, response) do
    Enum.reduce(
      Webapp.Request.get_cookies(response),
      conn,
      fn {name, value}, c -> put_resp_cookie(c, name, value, [{:path, "/"}]) end
    )
  end
end
