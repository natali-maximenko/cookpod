defmodule CookpodWeb.RecipleView do
  use CookpodWeb, :view
  alias Cookpod.Catalog.Image

  def image_url(reciple, version \\ :original) do
    Image.asset_host() <> Image.url({reciple.image, reciple}, version)
  end
end
