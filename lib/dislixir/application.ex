defmodule Dislixir.Application do
  use Application

  @moduledoc """
    Inicializa todos os modulos e o GenStage
  """

  def start(_type, _args) do
    children = [
      {Dislixir.Gateway, []},
      %{id: Dislixir.Stage.Producer, start: {Dislixir.Stage.Producer, :start_link, []}, name: Dislixir.Producer},
      %{id: Dislixir.Stage.Processor, start: {Dislixir.Stage.Processor, :start_link, []}, name: Dislixir.Processor},
      %{id: TestBot, start: {TestBot, :start, []}, name: Dislixir.Processor},
    ]

    opts = [strategy: :one_for_one, name: Dislixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
