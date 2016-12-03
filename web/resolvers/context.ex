defmodule Webapp.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = %{cookies: Webapp.Helper.get_cookies(conn)}
    put_private(conn, :absinthe, %{context: context})
  end
end
