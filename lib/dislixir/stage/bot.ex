defmodule Dislixir.Bot do

  @moduledoc """
    Esse modulo inicializa o ConsumerSupervisor para um modulo de Bot
    ao utilizar o macro `use`.
  """
  use ConsumerSupervisor

  defmacro __using__(_) do
    quote location: :keep do

      def start() do
        Dislixir.Bot.start_link(child_spec())
      end

      def start_link(event) do
        Task.start_link(fn -> __MODULE__.on_event(event[:event], event[:data])end)
      end

      def child_spec do
        %{
          id: __MODULE__,
          start: {__MODULE__, :start_link, []},
          type: :worker,
          restart: :temporary
        }
      end

    end
  end

  def start_link(mod) do
    ConsumerSupervisor.start_link(__MODULE__, mod)
  end

  def init(mod) do
    children = [
      mod
    ]
    opts = [strategy: :one_for_one, subscribe_to: [{Dislixir.Processor, max_demand: 50}]]
    ConsumerSupervisor.init(children, opts)
  end
end
