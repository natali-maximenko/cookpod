defmodule Cookpod.Catalog.Reciple do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reciples" do
    field :description, :string
    field :image, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(reciple, attrs) do
    reciple
    |> cast(attrs, [:title, :description, :image])
    |> validate_required([:title, :description, :image])
    |> unique_constraint(:title)
  end
end
