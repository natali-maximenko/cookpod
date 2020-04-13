defmodule CookpodWeb.Plugs.BasicAuth do
  import Plug.Conn
  @realm "Basic realm=\"Thou Shalt not pass\""

  def init(opts) do
    _ = Keyword.fetch!(opts, :username)
    _ = Keyword.fetch!(opts, :password)
    opts
  end

  def call(conn, opts) do
    case get_req_header(conn, "authorization") do
      ["Basic " <> auth] ->
        validate_auth(conn, auth, opts)

      _ ->
        unauthorized(conn)
    end
  end

  defp validate_auth(conn, auth, username: username, password: password) do
    case encode(username, password) do
      ^auth -> conn
      _ -> unauthorized(conn)
    end
  end

  defp encode(username, password), do: Base.encode64(username <> ":" <> password)

  defp unauthorized(conn) do
    conn
    |> put_resp_header("www-authenticate", @realm)
    |> send_resp(401, "unauthorized")
    |> halt()
  end
end
