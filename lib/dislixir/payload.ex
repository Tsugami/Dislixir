defmodule Dislixir.Payload do
  @moduledoc """
      Esse modulo serve pra construir
      Payloads pequenos e essenciais ao funcionamento da lib.
      Isso inclui os eventos de: Heartbeat, Hello e Identify
  """
  alias Dislixir.Constants.OpCodes

  def heartbeat_bin do
    %{"op" => OpCodes.heartbeat, "d" => %{}}
    |> :erlang.term_to_binary
  end

  def identify_bin(token) when is_binary(token) do
    {os, name} = :os.type()
    %{
      "op" => OpCodes.identify,
      "d" => %{
        "token" => token,
        "properties" => %{
          "$os" => Atom.to_string(os) <> " " <> Atom.to_string(name),
          "$browser" => "Elitro",
          "$device" => "Elitro",
        },
        "s" => nil,
        "t" => nil
      }
    }
    |> :erlang.term_to_binary
  end
end
