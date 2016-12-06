defmodule Webapp.TTRefresh do
  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _), do: Webapp.Helper.refresh_tt(conn)
end
