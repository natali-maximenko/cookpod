defmodule Cookpod.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :fats, :float
      add :carbs, :float
      add :proteins, :float

      timestamps()
    end
  end
end
