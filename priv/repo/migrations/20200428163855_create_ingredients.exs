defmodule Cookpod.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :amount, :integer
      add :reciple_id, references(:reciples, on_delete: :delete_all)
      add :product_id, references(:products, on_delete: :delete_all)

      timestamps()
    end

    create index(:ingredients, [:reciple_id, :product_id], unique: true)
  end
end
