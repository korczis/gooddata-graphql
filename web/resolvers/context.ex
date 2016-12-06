defmodule Webapp.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    put_private(conn, :absinthe, %{context: %{cookies: conn.cookies}})
  end
end
