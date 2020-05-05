defmodule Cookpod.Catalog.Reciple do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Cookpod.Catalog.{Image, Ingredient}

  schema "reciples" do
    field :description, :string
    field :image, Image.Type
    field :title, :string
    field :state, :string

    has_many :ingridients, Ingredient
    has_many :products, through: [:ingridients, :product]

    timestamps()
  end

  @doc false
  def changeset(reciple, attrs) do
    reciple
    |> cast(attrs, [:title, :description, :state])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:title, :description, :state])
    |> unique_constraint(:title)
  end
end
