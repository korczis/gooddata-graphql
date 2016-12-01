defmodule Webapp.Request do
  @host Application.get_env(:webapp, Webapp.Endpoint)[:gooddata][:host]

  @headers [
    {"Content-Type", "application/json"},
    {"Accept", "application/json"}
  ]

  def post(url, payload) do
    remote_url = "https://#{@host}#{url}"

    HTTPoison.post!(remote_url, Poison.encode!(payload), @headers)
  end
end
