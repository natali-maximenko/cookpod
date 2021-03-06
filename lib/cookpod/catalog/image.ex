defmodule Cookpod.Catalog.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .png)

  def __storage, do: Arc.Storage.Local

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()
    Enum.member?(@extension_whitelist, file_extension)
  end

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100 -format png", :png}
  end

  def filename(version, _) do
    version
  end

  def asset_host, do: "http://localhost:4000"

  def storage_dir(_, {_, scope}) do
    "uploads/reciple/images/#{scope.id}"
  end

  def default_url(version, _) do
    "/images/reciples/default_#{version}.png"
  end
end
