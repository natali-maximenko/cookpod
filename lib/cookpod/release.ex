defmodule Cookpod.Release do
  @moduledoc """
  Helper functions for managing releases.
  """
  @app :cookpod
  alias Ecto.Migrator

  def create do
    load_app()

    for repo <- repos() do
      case repo.__adapter__.storage_up(repo.config) do
        :ok ->
          IO.puts("The database for #{inspect(repo)} has been created")

        {:error, :already_up} ->
          IO.puts("The database for #{inspect(repo)} has already been created")

        {:error, term} when is_binary(term) ->
          raise "The database for #{inspect(repo)} couldn't be created: #{term}"

        {:error, term} ->
          raise "The database for #{inspect(repo)} couldn't be " <>
                  "created: #{inspect(term)}"
      end
    end
  end

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Migrator.with_repo(repo, &Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Migrator.with_repo(repo, &Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
