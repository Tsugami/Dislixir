
defmodule Dislixir.Constants.OpCodes do
  @moduledoc """
    Esse modulo contem todas as constantes de Opcode do gateway do discord
  """
  @opcodes %{
    DISPATCH: 0,
    HEARTBEAT: 1,
    IDENTIFY: 2,
    PRESENCE_UPDATE: 3,
    VOICE_STATE_UPDATE: 4,
    RESUME: 6,
    RECONNECT: 7,
    REQUEST_GUILD_MEMBERS: 8,
    INVALID_SESSION: 9,
    HELLO: 10,
    HEARTBEAT_ACK: 11,
  }

  def get_codes, do: @opcodes
   # An event was dispatched.
  def dispatch, do: get_codes()[:DISPATCH]
  # Fired periodically by the client to keep the connection alive.
  def heartbeat, do: get_codes()[:HEARTBEAT]
  # Starts a new session during the initial handshake.
  def identify, do: get_codes()[:IDENTIFY]
  # Update the client's presence.
  def presence_update, do: get_codes()[:PRESENCE_UPDATE]
  #Used to join/leave or move between voice channels.
  def voice_state_update, do: get_codes()[:VOICE_STATE_UPDATE]
  # Resume a previous session that was disconnected.
  def resume, do: get_codes()[:RESUME]
  # You should attempt to reconnect and resume immediately.
  def reconnect, do: get_codes()[:RECONNECT]
  # Request information about offline guild members in a large guild.
  def request_guild_members, do: get_codes()[:REQUEST_GUILD_MEMBERS]
  # The session has been invalidated. You should reconnect and identify/resume accordingly.
  def invalid_session, do: get_codes()[:INVALID_SESSION]
  # Sent immediately after connecting, contains the "heartbeat_interval" to use.
  def hello, do: get_codes()[:HELLO] # nao pode nome maiusuclo em funcao tbm
  # Sent in response to receiving a heartbeat to acknowledge that it has been received
  def heartbeat_ack, do: get_codes()[:HEARTBEAT_ACK]
end
