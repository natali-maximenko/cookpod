defmodule Cookpod.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :carbs, :float, default: 0
    field :fats, :float, default: 0
    field :proteins, :float, default: 0

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :fats, :carbs, :proteins])
    |> validate_required([:name, :fats, :carbs, :proteins])
  end
end
