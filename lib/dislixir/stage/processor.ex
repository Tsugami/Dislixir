defmodule Dislixir.Stage.Processor do
  use GenStage

  @moduledoc """
    Modulo que processa todos os eventos em structs.
  """

  def start_link() do
    GenStage.start_link(__MODULE__, [], name: Dislixir.Processor)
  end

  def init([]) do
    {:producer_consumer,  {:queue.new, 0}, subscribe_to: [{Dislixir.Producer, max_demand: 50}]}
  end

  def handle_events(events, _from, state) do
    {:noreply, events, state}
  end

end
