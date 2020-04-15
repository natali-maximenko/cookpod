defmodule CookpodWeb.PageControllerTest do
  use CookpodWeb.ConnCase
  import Plug.Test
  alias Cookpod.Accounts

  def with_valid_authorization_header(conn) do
    conn
    |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
  end

  def with_invalid_authorization_header(conn) do
    conn
    |> put_req_header("authorization", "Basic Knock knock neo")
  end

  setup %{conn: conn} do
    {:ok, user} =
      Accounts.create_user(%{
        email: "username@yandex.ru",
        password: "password",
        password_confirmation: "password"
      })

    %{conn: conn, user: user}
  end

  describe "GET index page /" do
    test "GET / without authorization header should throw 401", %{conn: conn} do
      conn = get(conn, Routes.page_path(conn, :index))
      assert response(conn, 401) == "unauthorized"
      assert get_resp_header(conn, "www-authenticate") == ["Basic realm=\"Thou Shalt not pass\""]
    end

    test "GET / with incorrect authorization should throw 401", %{conn: conn} do
      conn =
        conn
        |> with_invalid_authorization_header()
        |> get(Routes.page_path(conn, :index))

      assert response(conn, 401) == "unauthorized"
      assert get_resp_header(conn, "www-authenticate") == ["Basic realm=\"Thou Shalt not pass\""]
    end

    test "GET / with correct authorization should be OK", %{conn: conn} do
      conn =
        conn
        |> with_valid_authorization_header()
        |> get(Routes.page_path(conn, :index))

      assert html_response(conn, 200) =~ "You are not logged in"
    end
  end

  describe "GET protected page /terms" do
    test "not loggined user without basic auth", %{conn: conn} do
      conn =
        conn
        |> with_invalid_authorization_header()
        |> get(Routes.page_path(conn, :terms))

      assert response(conn, 401) == "unauthorized"
      assert get_resp_header(conn, "www-authenticate") == ["Basic realm=\"Thou Shalt not pass\""]
      refute conn.assigns[:current_user]
    end

    test "not loggined user with basic auth", %{conn: conn} do
      conn =
        conn
        |> with_valid_authorization_header()
        |> get(Routes.page_path(conn, :terms))

      assert redirected_to(conn) == "/sessions/new"
      assert get_flash(conn, :info) == "You need login"
      refute conn.assigns[:current_user]
    end

    test "loggined user with basic auth", %{conn: conn, user: user} do
      conn =
        conn
        |> with_valid_authorization_header()
        |> init_test_session(current_user: user)
        |> get(Routes.page_path(conn, :terms))

      assert html_response(conn, 200) =~ "Welcome username@yandex.ru!"
      assert html_response(conn, 200) =~ "Условия и положения"
      assert conn.assigns[:current_user]
    end
  end
end
