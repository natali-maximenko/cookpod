defmodule Cookpod.Catalog.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cookpod.Catalog.{Product, Reciple}

  schema "ingredients" do
    field :amount, :integer
    belongs_to :reciple, Reciple
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
