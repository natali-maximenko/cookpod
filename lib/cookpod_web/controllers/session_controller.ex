defmodule CookpodWeb.SessionController do
  use CookpodWeb, :controller

  action_fallback CookpodWeb.FallbackController

  def show(conn, _params) do
    current_user = get_session(conn, :current_user)
    render(conn, "show.html", current_user: current_user)
  end

  def new(conn, _params) do
    render(conn, "new.html", errors: %{})
  end

  def create(conn, %{"user" => user}) do
    case validate_user(user) do
      errors when map_size(errors) == 0 ->
        conn
        |> put_flash(:info, "You have successfully logined!")
        |> put_session(:current_user, user["name"])
        |> assign(:current_user, user["name"])
        |> redirect(to: Routes.session_path(conn, :show, 1))

      errors ->
        render(conn, "new.html", errors: errors)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "You have successfully logout!")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  defp validate_user(user) do
    user
    |> Enum.reduce(%{}, fn {name, value}, acc ->
      if String.length(value) == 0, do: Map.put(acc, name, "#{name} cannot be blank"), else: acc
    end)
  end
end
