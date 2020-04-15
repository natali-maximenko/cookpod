defmodule Cookpod.Catalog.Reciple do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Cookpod.Catalog.Image

  schema "reciples" do
    field :description, :string
    field :image, Image.Type
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(reciple, attrs) do
    reciple
    |> cast(attrs, [:title, :description])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:title, :description])
    |> unique_constraint(:title)
  end
end
