defmodule CookpodWeb.RecipleControllerTest do
  use CookpodWeb.ConnCase
  import Plug.Test

  alias Cookpod.Accounts
  alias Cookpod.Catalog

  @create_attrs %{description: "some description", image: "some image", title: "some title"}
  @update_attrs %{
    description: "some updated description",
    image: "some updated image",
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, image: nil, title: nil}

  setup %{conn: conn} do
    {:ok, user} =
      Accounts.create_user(%{
        email: "username@yandex.ru",
        password: "password",
        password_confirmation: "password"
      })

    %{conn: conn, user: user}
  end

  def fixture(:reciple) do
    {:ok, reciple} = Catalog.create_reciple(@create_attrs)
    reciple
  end

  describe "index" do
    test "lists all reciples", %{conn: conn, user: user} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = get(conn, Routes.reciple_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reciples"
    end
  end

  describe "new reciple" do
    test "renders form", %{conn: conn, user: user} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = get(conn, Routes.reciple_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reciple"
    end
  end

  describe "create reciple" do
    test "redirects to show when data is valid", %{conn: conn, user: user} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = post(conn, Routes.reciple_path(conn, :create), reciple: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.reciple_path(conn, :show, id)

      conn = get(conn, Routes.reciple_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Reciple"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = post(conn, Routes.reciple_path(conn, :create), reciple: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reciple"
    end
  end

  describe "edit reciple" do
    setup [:create_reciple]

    test "renders form for editing chosen reciple", %{conn: conn, user: user, reciple: reciple} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = get(conn, Routes.reciple_path(conn, :edit, reciple))
      assert html_response(conn, 200) =~ "Edit Reciple"
    end
  end

  describe "update reciple" do
    setup [:create_reciple]

    test "redirects when data is valid", %{conn: conn, user: user, reciple: reciple} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = put(conn, Routes.reciple_path(conn, :update, reciple), reciple: @update_attrs)
      assert redirected_to(conn) == Routes.reciple_path(conn, :show, reciple)

      conn = get(conn, Routes.reciple_path(conn, :show, reciple))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user, reciple: reciple} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = put(conn, Routes.reciple_path(conn, :update, reciple), reciple: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Reciple"
    end
  end

  describe "publish reciple" do
    setup [:create_reciple]

    test "updates state", %{conn: conn, user: user, reciple: reciple} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = put(conn, Routes.reciple_path(conn, :publish, reciple))
      assert redirected_to(conn) == Routes.reciple_path(conn, :show, reciple)

      conn = get(conn, Routes.reciple_path(conn, :show, reciple))
      assert html_response(conn, 200) =~ "published"
    end
  end

  describe "delete reciple" do
    setup [:create_reciple]

    test "deletes chosen reciple", %{conn: conn, user: user, reciple: reciple} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")
        |> init_test_session(current_user: user)

      conn = delete(conn, Routes.reciple_path(conn, :delete, reciple))
      assert redirected_to(conn) == Routes.reciple_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.reciple_path(conn, :show, reciple))
      end
    end
  end

  defp create_reciple(_) do
    reciple = fixture(:reciple)
    {:ok, reciple: reciple}
  end
end
