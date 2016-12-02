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

    cookie_list = Enum.map(cookie_list,
      fn {_k, v} ->
        List.first(String.split(v, ";"))
      end
    )

    cookies = Enum.join(cookie_list, "; ")
    data = Poison.decode!(res.body)

    profile_url = get_in(data, ["userLogin", "profile"])
    profile = Poison.decode!(Webapp.Request.get(profile_url, cookie_list).body)

    conn
    |> put_resp_header("Set-Cookie", cookies)
    |> json(data)
  end

  def sign_out(conn, _params) do
    conn
    |> json(%{})
  end

  def user(conn, _params) do
    data = Poison.decode!(Webapp.Request.get("/gdc/app/account/bootstrap", get_cookies(conn)).body)
    user = get_in(data, ["bootstrapResource", "accountSetting"])

    conn
    |> json(user)
  end

  defp get_cookies(conn) do
    Enum.filter(conn.req_headers,
      fn {k, _v} ->
        k == "cookie"
      end
    )
    |> Enum.map(fn {_k, v} -> v end)
  end
end
