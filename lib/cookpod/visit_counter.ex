defmodule Cookpod.VisitCounter do
  use GenServer

  # Client

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: :counter)
  end

  def visit(reciple_id) do
    GenServer.cast(:counter, {:visit, reciple_id})
  end

  def statistic do
    GenServer.call(:counter, :statistic)
  end

  # Server (callbacks)
  @impl true
  def init(data) do
    {:ok, data}
  end

  @impl true
  def handle_call(:statistic, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:visit, reciple_id}, state) do
    {:noreply, update_state(state, reciple_id)}
  end

  defp update_state(state, reciple_id) do
    case Map.fetch(state, reciple_id) do
      {:ok, visits} ->
        Map.merge(state, %{reciple_id => visits + 1})

      :error ->
        Map.merge(state, %{reciple_id => 1})
    end
  end
end
