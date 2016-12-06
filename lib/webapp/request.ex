defmodule Webapp.Request do
  require Logger

  @host Application.get_env(:webapp, Webapp.Endpoint)[:gooddata][:host]

  @headers [
    {"Content-Type", "application/json"},
    {"Accept", "application/json"}
  ]

  @options Application.get_env(:webapp, Webapp.Endpoint)[:httpoison]

  def get(url, cookies \\ %{}) do
    Logger.info "GET #{url}"

    remote_url = "https://#{@host}#{url}"
    HTTPoison.get!(remote_url, get_headers(cookies), @options)
  end

  def post(url, payload, cookies \\ %{}) do
    Logger.info "POST #{url}"

    remote_url = "https://#{@host}#{url}"
    HTTPoison.post!(remote_url, Poison.encode!(payload), get_headers(cookies), @options)
  end

  def get_cookies(response) do
    Map.new(Enum.filter_map(
      response.headers,
      fn {k, _v} -> k == "Set-Cookie" end,
      fn {_k, v} -> String.split(List.first(String.split(v, ";")), "=") end
    ), fn([k, v]) -> {k, v} end)
  end

  defp get_headers(cookies) do
    case map_size(cookies) do
      0 -> @headers
      _ -> [{"cookie", encode_cookies(cookies)} | @headers]
    end
  end

  defp encode_cookies(cookies) do
    cookies
    |> Map.to_list
    |> Enum.map(fn({k, v}) -> "#{k}=#{v}" end)
    |> Enum.join("; ")
  end
end
