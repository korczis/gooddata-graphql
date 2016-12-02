defmodule Webapp.Helper do
  def get_cookies(conn) do
    Enum.filter(conn.req_headers,
      fn {k, _v} ->
        k == "cookie"
      end
    )
    |> Enum.map(fn {_k, v} -> v end)
  end
end
