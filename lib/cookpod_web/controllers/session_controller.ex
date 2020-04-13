defmodule CookpodWeb.SessionController do
  use CookpodWeb, :controller
  alias Cookpod.Accounts.Auth

  action_fallback CookpodWeb.FallbackController

  def show(conn, _params) do
    current_user = get_session(conn, :current_user)
    render(conn, "show.html", current_user: current_user)
  end

  def new(conn, _params) do
    render(conn, "new.html", errors: %{})
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Auth.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "You have successfully logined!")
        |> put_session(:current_user, user)
        |> assign(:current_user, user)
        |> redirect(to: Routes.session_path(conn, :show, 1))

      {:error, msg} ->
        conn
        |> put_flash(:info, msg)
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "You have successfully logout!")
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
