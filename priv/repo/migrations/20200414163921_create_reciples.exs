defmodule Cookpod.Repo.Migrations.CreateReciples do
  use Ecto.Migration

  def change do
    create table(:reciples) do
      add :title, :string
      add :description, :text
      add :image, :string

      timestamps()
    end

    create unique_index(:reciples, [:title])
  end
end
