defmodule Webapp.Request do
  require Logger

  @headers [
    {"Content-Type", "application/json"},
    {"Accept", "application/json"}
  ]

  @options Application.get_env(:webapp, Webapp.Endpoint)[:httpoison]

  def get(url, cookies \\ %{}, use_cache \\ true) do
    key = "GET #{url}"
    case Cachex.get(:rest_cache, key) do
      {:ok, result} ->
        Logger.info "Cached #{key}"
        result
      _ ->
        Logger.info key
        res = HTTPoison.get!(construct_url(url), get_headers(cookies), @options)
        if use_cache do
          Cachex.set(:rest_cache, key, res)
        end
        res
    end
  end

  def post(url, payload, cookies \\ %{}) do
    Logger.info "POST #{url}"
    remote_url = construct_url(url)
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

  defp construct_url(url) do
    host = Application.get_env(:webapp, Webapp.Endpoint)[:gooddata][:host]
    "https://#{host}#{url}"
  end
end
