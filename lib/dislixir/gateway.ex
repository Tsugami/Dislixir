defmodule Dislixir.Gateway do
  use GenServer

  @moduledoc """
    Esse modulo serve para conectar ao gateway do discord usando gun.
    Ele manda todos os eventos para o Stage.Producer
  """

  alias Dislixir.Constants
  alias Dislixir.Constants.OpCodes

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    {:ok, state, {:continue, :start}}
  end

  def handle_continue(:start, state) do
    res = HTTPoison.get!(Constants.base_url("gateway"))
    ws_url = String.slice(Poison.decode!(res.body)["url"], 6..-1)
    {:ok, conn_pid} = :gun.open(to_charlist(ws_url), 443, %{protocols: [:http]})
    {:ok, _protocol} = :gun.await_up(conn_pid)
    :gun.ws_upgrade(conn_pid, "/?v=6&encoding=etf")
    {:noreply, %{conn_pid: conn_pid}}
  end

  def handle_info({:gun_upgrade, _, _, ["websocket"], _headers}, state) do
    {:noreply, state}
  end

  def handle_info({:gun_ws, _, _, {:binary, packet}}, state) do
    info = :erlang.binary_to_term(packet)
    data = info.d
    case info.op do
      10 ->
        token = Application.fetch_env!(:dislixir, :token)
        binary = Dislixir.Payload.identify_bin(token)
        :gun.ws_send(state.conn_pid, {:binary, binary})
        interval = data.heartbeat_interval
        Process.send_after(self, {:heartbeat, interval}, 1000)
      0 ->
        Dislixir.Stage.Producer.enqueue(%{event: info.t, data: info.d})
      11 -> 
        false # alooo?
      other ->
        false
    end
    {:noreply, state}
  end


  def handle_info({:gun_ws, _, _, other}, state) do
    {:noreply, state}
  end

  # Isso é pra dar heartbeat.
  def handle_info({:heartbeat, interval}, state) do
    :gun.ws_send(state.conn_pid, {:binary, Dislixir.Payload.heartbeat_bin})
    Process.send_after(self, {:heartbeat, interval}, interval)
    {:noreply, state}
  end

  # certo esse ultimo é pra caso de errado e nao tenhamos como dar handle certo?
  def handle_info(data, state) do
    IO.puts "Received #{inspect(data)} with state #{inspect(state)}"
    {:noreply, state}
  end

end
