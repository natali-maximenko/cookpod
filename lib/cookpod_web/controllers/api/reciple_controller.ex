defmodule CookpodWeb.Api.RecipleController do
  use CookpodWeb, :controller
  use PhoenixSwagger

  alias Cookpod.Catalog

  def swagger_definitions do
    %{
      Reciple:
        swagger_schema do
          title("Reciple")
          description("A Reciple in the app")

          properties do
            id(:integer, "Reciple ID")
            title(:string, "Reciple title", required: true)
            description(:string, "Description", required: true)
          end

          example(%{
            id: 123,
            title: "Title",
            description: "Some sescription"
          })
        end,
      RecipleRequest:
        swagger_schema do
          title("RecipleRequest")
          description("POST body for creating a Reciple")
          property(:Reciple, Schema.ref(:Reciple), "The Reciple details")
        end,
      RecipleResponse:
        swagger_schema do
          title("RecipleResponse")
          description("Response schema for single Reciple")
          property(:data, Schema.ref(:Reciple), "The Reciple details")
        end,
      ReciplesResponse:
        swagger_schema do
          title("ReciplesReponse")
          description("Response schema for multiple Reciples")
          property(:data, Schema.array(:Reciple), "The Reciples details")
        end
    }
  end

  swagger_path(:index) do
    get("/api/reciples")
    summary("List Reciples")
    description("List all reciples in the database")
    produces("application/json")
    deprecated(false)

    response(200, "OK", Schema.ref(:ReciplesResponse),
      example: [
        %{
          id: 1,
          title: "Cake",
          description: "sweet cake"
        },
        %{
          id: 2,
          title: "Tea",
          description: "sweet green tea"
        }
      ]
    )
  end

  def index(conn, _params) do
    reciples = Catalog.list_reciples()
    render(conn, "index.json", reciples: reciples)
  end

  swagger_path(:show) do
    summary("Show Reciple")
    description("Show a reciple by ID")
    produces("application/json")
    parameter(:id, :path, :integer, "Reciple ID", required: true, example: 123)

    response(200, "OK", Schema.ref(:RecipleResponse),
      example: %{
        id: 123,
        title: "Cake",
        description: "sweet cake"
      }
    )
  end

  def show(conn, %{"id" => id}) do
    reciple = Catalog.get_reciple!(id)
    render(conn, "show.json", reciple: reciple)
  end
end
