defmodule CookpodWeb.Api.RecipleController do
  use CookpodWeb, :controller

  alias Cookpod.Catalog

  def index(conn, _params) do
    reciples = Catalog.list_reciples()
    render(conn, "index.json", reciples: reciples)
  end

  def show(conn, %{"id" => id}) do
    reciple = Catalog.get_reciple!(id)
    render(conn, "show.json", reciple: reciple)
  end
end
