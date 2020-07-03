defmodule Dislixir.Endpoints do
  @moduledoc """
    Constantes dos endpoints
  """
  def channel_messages(channel_id), do: "/channels/#{channel_id}/messages"
end
