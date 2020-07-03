defmodule DislixirTest.Bot do
  use ExUnit.Case
  doctest Dislixir

  alias Dislixir.Constants.OpCodes

  test "test bot" do
    defmodule MyBot do
      use Dislixir.Bot

      def on_event(:ready) do

      end
    end
  end

end
