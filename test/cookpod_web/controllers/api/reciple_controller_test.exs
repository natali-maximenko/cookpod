defmodule CookpodWeb.Api.RecipleControllerTest do
  use CookpodWeb.ConnCase, async: true
  use PhoenixSwagger.SchemaTest, "priv/static/swagger.json"

  alias Cookpod.Catalog

  @create_attrs %{description: "some description", title: "some title"}

  def fixture(:reciple) do
    {:ok, reciple} = Catalog.create_reciple(@create_attrs)
    reciple
  end

  describe "index" do
    setup [:create_reciple]

    test "lists all reciples", %{conn: conn, swagger_schema: schema} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")

      conn
      |> get(Routes.api_reciple_path(conn, :index))
      |> validate_resp_schema(schema, "ReciplesResponse")
      |> json_response(200)
    end
  end

  describe "show reciple" do
    setup [:create_reciple]

    test "get reciple", %{conn: conn, reciple: reciple, swagger_schema: schema} do
      conn =
        conn
        |> put_req_header("authorization", "Basic dXNlcjpzZWNyZXQ=")

      conn
      |> get(Routes.api_reciple_path(conn, :show, reciple))
      |> validate_resp_schema(schema, "RecipleResponse")
      |> json_response(200)
    end
  end

  defp create_reciple(_) do
    reciple = fixture(:reciple)
    {:ok, reciple: reciple}
  end
end
