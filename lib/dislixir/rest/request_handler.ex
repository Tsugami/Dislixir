defmodule Dislixir.RequestHandler do
  @moduledoc """
    Serve para mandar requisições a API do discord
  """
  use HTTPoison.Base
  alias Dislixir.Constants

  def process_request_url(url) do
    Constants.base_url(url)
  end

  def process_request_headers(headers) do
    token = Application.fetch_env!(:dislixir, :token)
    [{"Content-Type", "application/json"}, {"Authorization", "Bot " <> token}]
  end
end
