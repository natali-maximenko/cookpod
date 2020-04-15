defmodule CookpodWeb.RecipleView do
  use CookpodWeb, :view
  alias Cookpod.Catalog.Image
  alias CookpodWeb.Endpoint

  def image_url(reciple) do
    do_img_url(reciple.image, reciple)
  end

  defp do_img_url(nil, _), do: nil

  defp do_img_url(image, reciple) do
    Endpoint.url() <> Image.url({image, reciple}, :thumb)
  end
end
