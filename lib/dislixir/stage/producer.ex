defmodule Dislixir.Stage.Producer do

  @moduledoc """
    Ponto principal do backpressure da lib. Ele pega todos os eventos
    E manda para o Processor que transforma em structs e manda para os 
    Consumer Supervisors
  """
  use GenStage

  def start_link() do
    GenStage.start_link(__MODULE__, [], name: Dislixir.Producer)
  end

  def init(_) do
    state = {:queue.new, 0}
    {:producer, state}
  end

  defp dispatch_events(queue, 0, events), do: {:noreply, events, {queue, 0}}

  defp dispatch_events(queue, demand, events) do
    case :queue.out(queue) do
      {{:value, event}, queue} ->
        dispatch_events(queue, demand - 1, [event | events])
      {:empty, queue} ->
        {:noreply, events, {queue, demand}}
    end
  end

  def handle_cast({:enqueue, event}, {queue, demand}) do
    dispatch_events(:queue.in(event, queue), demand, [])
  end

  def enqueue(event) do
      GenServer.cast(Dislixir.Producer, {:enqueue, event})
  end

  def handle_demand(incoming_demand, {queue, demand}) do
   dispatch_events(queue, incoming_demand + demand, [])
  end

end
