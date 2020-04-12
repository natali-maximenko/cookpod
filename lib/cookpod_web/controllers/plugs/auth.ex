defmodule CookpodWeb.Plugs.Auth do
  import Plug.Conn, only: [get_session: 2, assign: 3, halt: 1]
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]
  alias CookpodWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = get_session(conn, :current_user)

    case current_user do
      nil ->
        conn
        |> halt()
        |> put_flash(:info, "You need login")
        |> redirect(to: Routes.session_path(conn, :new))

      _ ->
        conn
        |> assign(:current_user, current_user)
    end
  end
end
