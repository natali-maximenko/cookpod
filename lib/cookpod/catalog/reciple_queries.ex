defmodule Cookpod.Catalog.RecipleQueries do
  import Ecto.Query, warn: false

  alias Cookpod.Catalog.Reciple
  alias Cookpod.Repo

  def list, do: Repo.all(Reciple)
  def get!(id), do: Repo.get!(Reciple, id)
  def change(%Reciple{} = reciple), do: Reciple.changeset(reciple, %{})
  def delete(%Reciple{} = reciple), do: Repo.delete(reciple)

  def create(attrs \\ %{}) do
    %Reciple{}
    |> Reciple.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Reciple{} = reciple, attrs) do
    reciple
    |> Reciple.changeset(attrs)
    |> Repo.update()
  end
end
