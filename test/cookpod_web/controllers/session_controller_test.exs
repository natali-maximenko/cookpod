defmodule CookpodWeb.SessinControllerTest do
  use CookpodWeb.ConnCase
  import Plug.Test

  @invalid_params %{
    email: "username",
    password: ""
  }

  setup %{conn: conn} do
    conn = with_valid_authorization_header(conn)
    user = insert(:user)

    %{conn: conn, user: user}
  end

  test "GET /sessions/new", %{conn: conn} do
    conn = get(conn, Routes.session_path(conn, :new))
    assert html_response(conn, 200) =~ "Log in"
  end

  test "POST /sessions", %{conn: conn, user: user} do
    params = %{
      email: user.email,
      password: "password"
    }

    conn = post(conn, Routes.session_path(conn, :create, user: params))

    assert redirected_to(conn) == "/sessions/1"
    assert get_flash(conn, :info) == "You have successfully logined!"
    assert conn.assigns[:current_user].email == user.email
  end

  test "POST /sessions with invalid params", %{conn: conn} do
    conn = post(conn, Routes.session_path(conn, :create, user: @invalid_params))

    assert get_flash(conn, :info) == "Incorrect email"
    refute conn.assigns[:current_user]
  end

  test "SHOW /sessions/1", %{conn: conn, user: user} do
    conn =
      conn
      |> init_test_session(current_user: user)
      |> get(Routes.session_path(conn, :show, 1))

    assert html_response(conn, 200) =~ "You are logged in as #{user.email}"
    assert html_response(conn, 200) =~ "Log out"
  end

  test "DELETE /sessions", %{conn: conn, user: user} do
    conn =
      conn
      |> init_test_session(current_user: user)
      |> delete(Routes.session_path(conn, :delete, 1))

    assert redirected_to(conn) == "/sessions/new"
    assert get_flash(conn, :info) == "You have successfully logout!"
    refute conn.assigns[:current_user]
  end
end
