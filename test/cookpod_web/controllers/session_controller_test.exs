defmodule CookpodWeb.SessinControllerTest do
  use CookpodWeb.ConnCase
  import Plug.Test

  @params %{
    name: "username",
    password: "password"
  }

  @invalid_params %{
    name: "",
    password: ""
  }

  test "GET /sessions/new", %{conn: conn} do
    conn = get(conn, Routes.session_path(conn, :new))
    assert html_response(conn, 200) =~ "Log in"
  end

  test "POST /sessions", %{conn: conn} do
    conn = post(conn, Routes.session_path(conn, :create, user: @params))

    assert redirected_to(conn) == "/sessions/1"
    assert get_flash(conn, :info) == "You have successfully logined!"
    assert conn.assigns[:current_user] == "username"
  end

  test "POST /sessions with invalid params", %{conn: conn} do
    conn = post(conn, Routes.session_path(conn, :create, user: @invalid_params))

    assert html_response(conn, 200) =~ "name cannot be blank"
    assert html_response(conn, 200) =~ "password cannot be blank"
    refute conn.assigns[:current_user]
  end

  test "SHOW /sessions/1", %{conn: conn} do
    conn =
      conn
      |> init_test_session(current_user: "username")
      |> get(Routes.session_path(conn, :show, 1))

    assert html_response(conn, 200) =~ "You are logged in as username"
    assert html_response(conn, 200) =~ "Log out"
  end

  test "DELETE /sessions", %{conn: conn} do
    conn =
      conn
      |> init_test_session(current_user: "username")
      |> delete(Routes.session_path(conn, :delete, 1))

    assert redirected_to(conn) == "/sessions/new"
    assert get_flash(conn, :info) == "You have successfully logout!"
    refute conn.assigns[:current_user]
  end
end
