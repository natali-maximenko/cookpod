defmodule CookpodWeb.Api.RecipleControllerTest do
  use CookpodWeb.ConnCase

  alias Cookpod.Catalog

  @create_attrs %{description: "some description", title: "some title"}

  def fixture(:reciple) do
    {:ok, reciple} = Catalog.create_reciple(@create_attrs)
    reciple
  end

  describe "index" do
    setup [:create_reciple]

    test "lists all reciples", %{conn: conn, reciple: reciple} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")

      expected = [
        %{
          "id" => reciple.id,
          "description" => "some description",
          "image" => "/images/reciples/default_original.png",
          "title" => "some title"
        }
      ]

      conn = get(conn, Routes.api_reciple_path(conn, :index))
      assert response = json_response(conn, 200)
      assert expected == response
    end
  end

  describe "show reciple" do
    setup [:create_reciple]

    test "get reciple", %{conn: conn, reciple: reciple} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")

      conn = get(conn, Routes.api_reciple_path(conn, :show, reciple))
      assert response = json_response(conn, 200)

      expected = %{
        "id" => reciple.id,
        "description" => "some description",
        "image" => "/images/reciples/default_original.png",
        "title" => "some title"
      }

      assert expected == response
    end
  end

  defp create_reciple(_) do
    reciple = fixture(:reciple)
    {:ok, reciple: reciple}
  end
end
