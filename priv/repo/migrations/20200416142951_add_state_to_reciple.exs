defmodule Cookpod.Repo.Migrations.AddStateToReciple do
  use Ecto.Migration

  def change do
    alter table(:reciples) do
      add :state, :string
    end
  end
end
