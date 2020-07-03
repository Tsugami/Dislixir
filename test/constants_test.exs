defmodule DislixirTest.Constants do
  use ExUnit.Case
  doctest Dislixir

  alias Dislixir.Constants.OpCodes

  test "test opcodes" do
    assert OpCodes.dispatch == 0
    assert OpCodes.heartbeat == 1
    assert OpCodes.identify == 2
    assert OpCodes.presence_update == 3
    assert OpCodes.voice_state_update == 4
    assert OpCodes.resume == 6
    assert OpCodes.reconnect == 7
    assert OpCodes.request_guild_members == 8
    assert OpCodes.invalid_session == 9
    assert OpCodes.hello == 10
    assert OpCodes.heartbeat_ack == 11
  end

end
