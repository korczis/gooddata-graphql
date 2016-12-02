defmodule Webapp.Request do
  @host Application.get_env(:webapp, Webapp.Endpoint)[:gooddata][:host]

  @headers [
    {"Content-Type", "application/json"},
    {"Accept", "application/json"}
  ]

  def get(url, cookies \\ nil) do
    remote_url = "https://#{@host}#{url}"
    HTTPoison.get!(remote_url, get_headers(cookies))
  end

  def post(url, payload, cookies \\ nil) do
    remote_url = "https://#{@host}#{url}"
    HTTPoison.post!(remote_url, Poison.encode!(payload), get_headers(cookies))
  end

  defp get_headers(cookies \\ nil) do
    headers = case cookies do
      nil -> @headers
      _ -> @headers ++ [{"cookie", Enum.join(cookies, "; ")}]
    end
  end
end
