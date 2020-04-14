defmodule Cookpod.Catalog do
  @moduledoc """
  The Catalog context.
  """
  alias Cookpod.Catalog.RecipleQueries

  def list_reciples, do: RecipleQueries.list()
  def get_reciple!(id), do: RecipleQueries.get!(id)
  def create_reciple(attrs), do: RecipleQueries.create(attrs)
  def update_reciple(reciple, attrs), do: RecipleQueries.update(reciple, attrs)
  def delete_reciple(reciple), do: RecipleQueries.delete(reciple)
  def change_reciple(reciple), do: RecipleQueries.change(reciple)
end
