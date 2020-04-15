defmodule Cookpod.Catalog.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  # @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .png)

  def __storage, do: Arc.Storage.Local

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()
    Enum.member?(@extension_whitelist, file_extension)
  end

  # def transform(:thumb, _) do
  #   {:convert, "-strip -thumbnail 100x100^ -gravity center -extent 100x100"}
  # end
end
