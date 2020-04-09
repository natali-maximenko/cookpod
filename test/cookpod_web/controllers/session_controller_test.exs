defmodule CookpodWeb.SessinControllerTest do
  use CookpodWeb.ConnCase

  @params %{
    name: "username",
    password: "password"
  }

  @invalid_params %{
    name: "",
    password: ""
  }

  test "GET /sessions/new", %{conn: conn} do
    conn = get(conn, "/sessions/new")
    assert html_response(conn, 200) =~ "Log in"
  end

  test "POST /sessions", %{conn: conn} do
    conn = post conn, "/sessions", user: @params

    assert redirected_to(conn) == "/sessions/1"
    assert get_flash(conn, :info) == "You have successfully logined!"
    assert conn.assigns[:current_user] == "username"
  end

  test "POST /sessions with invalid params", %{conn: conn} do
    conn = post conn, "/sessions", user: @invalid_params

    assert html_response(conn, 200) =~ "name cannot be blank"
    assert html_response(conn, 200) =~ "password cannot be blank"
    refute conn.assigns[:current_user]
  end

  test "DELETE /sessions", %{conn: conn} do
    conn = post conn, "/sessions", user: @params

    assert redirected_to(conn) == "/sessions/1"
    assert get_flash(conn, :info) == "You have successfully logined!"
    assert conn.assigns[:current_user] == "username"

    conn = delete(conn, "/sessions/1")
    assert redirected_to(conn) == "/sessions/new"
    assert get_flash(conn, :info) == "You have successfully logout!"
    refute conn.assigns[:current_user]
  end
end
