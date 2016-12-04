defmodule Webapp.Helper do
  def get_cookies(conn) do
    Enum.filter(conn.req_headers,
      fn {k, _v} ->
        k == "cookie"
      end
    )
    |> Enum.map(fn {_k, v} -> v end)
  end

  def transform_cookies(info) do
    String.split(List.first(Map.get(info.context, :cookies)), "; ")
  end
end
