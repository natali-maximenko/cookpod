defmodule Cookpod.VisitCounter do
  use GenServer
  @storage_name :cookpod_visits

  # Client

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def visit(reciple_id) do
    GenServer.cast(__MODULE__, {:visit, reciple_id})
  end

  def statistic do
    GenServer.call(__MODULE__, :statistic)
  end

  # Server (callbacks)
  @impl true
  def init(data) do
    :ets.new(@storage_name, [:named_table, :set, :public, read_concurrency: true])
    {:ok, data}
  end

  @impl true
  def handle_call(:statistic, _from, state) do
    statistics = get_all() |> Enum.into(%{})
    {:reply, statistics, state}
  end

  @impl true
  def handle_cast({:visit, reciple_id}, _state) do
    # {:noreply, update_state(state, reciple_id)}
    {:noreply, update_storage(reciple_id)}
  end

  defp get_all, do: :ets.tab2list(@storage_name)

  defp update_storage(reciple_id) do
    case :ets.lookup(@storage_name, reciple_id) do
      [] ->
        :ets.insert(@storage_name, {reciple_id, 1})
        {:ok, 1}

      [{^reciple_id, visits}] ->
        :ets.insert(@storage_name, {reciple_id, visits + 1})
        {:ok, visits}
    end
  end

  # defp update_state(state, reciple_id) do
  #   case Map.fetch(state, reciple_id) do
  #     {:ok, visits} ->
  #       Map.merge(state, %{reciple_id => visits + 1})

  #     :error ->
  #       Map.merge(state, %{reciple_id => 1})
  #   end
  # end
end
