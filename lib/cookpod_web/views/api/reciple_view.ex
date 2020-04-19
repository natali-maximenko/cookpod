defmodule CookpodWeb.Api.RecipleView do
  use CookpodWeb, :view

  alias Cookpod.Catalog.Image

  def render("index.json", %{reciples: reciples}) do
    render_many(reciples, __MODULE__, "reciple.json")
  end

  def render("show.json", %{reciple: reciple}) do
    render_one(reciple, __MODULE__, "reciple.json")
  end

  def render("reciple.json", %{reciple: reciple}) do
    %{
      title: reciple.title,
      description: reciple.description,
      image: Image.url({reciple.image, reciple})
    }
  end
end
