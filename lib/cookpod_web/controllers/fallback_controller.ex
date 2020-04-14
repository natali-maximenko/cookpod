defmodule CookpodWeb.FallbackController do
  use Phoenix.Controller
  alias CookpodWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> put_view(ErrorView)
    |> render(:"403")
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(422)
    |> put_flash(:info, message)
    |> put_view(ErrorView)
    |> render(:"422")
  end
end
