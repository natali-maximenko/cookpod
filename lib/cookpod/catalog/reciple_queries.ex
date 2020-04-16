defmodule Cookpod.Catalog.RecipleQueries do
  import Ecto.Query, warn: false

  alias Cookpod.Catalog.Reciple
  alias Cookpod.Catalog.RecipleFsm
  alias Cookpod.Repo

  def list, do: Repo.all(Reciple)
  def get!(id), do: Repo.get!(Reciple, id)
  def change(%Reciple{} = reciple), do: Reciple.changeset(reciple, %{})
  def delete(%Reciple{} = reciple), do: Repo.delete(reciple)

  def create(attrs \\ %{}) do
    %Reciple{state: init_state()}
    |> Reciple.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Reciple{} = reciple, attrs) do
    reciple
    |> Reciple.changeset(attrs)
    |> Repo.update()
  end

  def publish(%Reciple{} = reciple) do
    reciple
    |> Reciple.changeset(%{state: publish_state()})
    |> Repo.update()
  end

  defp init_state do
    RecipleFsm.new()
    |> RecipleFsm.state()
    |> Atom.to_string()
  end

  defp publish_state do
    RecipleFsm.new()
    |> RecipleFsm.publish()
    |> RecipleFsm.state()
    |> Atom.to_string()
  end
end
