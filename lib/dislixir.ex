defmodule Dislixir do
  alias Dislixir.Endpoints
  alias Dislixir.RequestHandler

  @moduledoc """
    Modulo para mandar requisições a API do discord
  """

  def create_message(channel_id, content) do
    message = Poison.encode!(%{"content" => content})
    RequestHandler.post! Endpoints.channel_messages(channel_id), message
  end
end
