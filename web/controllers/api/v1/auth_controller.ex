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

    cookie_list = Enum.filter(res.headers,
      fn {k, _v} ->
        k == "Set-Cookie"
      end
    )

    data = Poison.decode!(res.body)

    Enum.reduce(
      cookie_list,
      conn,
      fn {_k, v}, c ->
        cookie = List.first(String.split(v, ";"))
        [name, value] = String.split(cookie, "=")
        c
        |> put_resp_cookie(name, value, [{:path, "/"}])
      end
    )
    |> json(data)
  end

  def sign_out(conn, _params) do
    conn
    |> json(%{})
  end

  def user(conn, _params) do
    data = Poison.decode!(Webapp.Request.get("/gdc/app/account/bootstrap", Webapp.Helper.get_cookies(conn)).body)
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
end
