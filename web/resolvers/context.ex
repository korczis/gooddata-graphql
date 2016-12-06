defmodule Webapp.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    conn
    |> Webapp.Helper.refresh_tt
    |> put_context
  end

  defp put_context(conn) do
    put_private(conn, :absinthe, %{context: %{cookies: conn.cookies}})
  end
end
