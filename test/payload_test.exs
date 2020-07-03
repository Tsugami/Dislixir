defmodule DislixirTest.Payload do
  use ExUnit.Case
  doctest Dislixir

  alias Dislixir.Payload
  alias Dislixir.Constants.OpCodes

  test "test hello payload" do
    payload_bin = Payload.gen_hello_bin
    map =  :erlang.binary_to_term(payload_bin)
    assert map == %{op: OpCodes.hello, d: %{heartbeat: 45_000}}
  end


  test "test identify payload" do
    payload_bin = Payload.gen_identify_bin("oloco meu")
    map =  :erlang.binary_to_term(payload_bin)
    expected = %{op: OpCodes.identify, d: %{
      token: "oloco meu",
      properties: %{
        "$os" => "linux",
        "$browser" => "elitro",
        "$device" => "elitro",
      }
    }}
    assert map == expected
  end

end
