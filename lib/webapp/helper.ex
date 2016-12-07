defmodule Webapp.Helper do
  require Logger

  import Plug.Conn

  @tt "GDCAuthTT"
  @tt_timestamp "TTTimestamp"

  def refresh_tt(conn) do
    last_timestamp = Map.get(conn.cookies, @tt_timestamp)
    case last_timestamp do
      nil ->
        conn
      _ ->
        case (tt_timestamp - String.to_integer(last_timestamp)) > 10 * 60 do
          true ->
            Logger.info "TT refresh needed"
            res = Webapp.Request.get("/gdc/account/token", conn.cookies)
            case res.status_code do
              200 ->
                Logger.info "TT refreshed"
                tt = Map.get(Webapp.Request.get_cookies(res), @tt)
                conn
                |> put_resp_cookie(@tt, tt)
                |> tt_refreshed
              _ ->
                Logger.error "TT refresh failed: #{inspect(res)}"
                conn
            end
          false ->
            Logger.info "TT refresh not needed"
            conn
        end
    end
  end

  def tt_refreshed(conn) do
    put_resp_cookie(conn, @tt_timestamp, "#{tt_timestamp}", [{:path, "/"}])
  end

  defp tt_timestamp do
    System.os_time(:seconds)
  end
end
