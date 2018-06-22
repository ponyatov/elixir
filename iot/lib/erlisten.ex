defmodule ErListener do
  @moduledoc """
  ErTelecom application socket listener for ThingPark downlink http://:8001
  
  see manual on writing socket server in Elixir:
  
  https://robots.thoughtbot.com/playing-with-sockets-and-processes-in-elixir
  https://elixir-lang.org/getting-started/mix-otp/task-and-gen-tcp.html
  
  """
  
  require Logger
  
  @iot_north_port 8001

  @doc "listen on selected port"
  def start(port\\@iot_north_port) do
    spawn fn ->
      case :gen_tcp.listen(port,[:binary, active: false, reuseaddr: true]) do
        {:ok,socket} ->
          Logger.info("connected on #{inspect port}")
          accept_connection(socket)
        {:error,reason} ->
          Logger.error("listen #{inspect port} error #{inspect reason}")
      end
    end
  end
  
  @doc "accept connection to spawning serve process"
  def accept_connection(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    spawn fn ->
      {:ok, buffer} = Buffer.create()
      Logger.info "Buffer: #{inspect buffer}"
      Process.flag(:trap_exit, true)					# break crash link
      Logger.info "client:#{inspect client} with buffer:#{inspect buffer}"
      serve(client, buffer)
    end
    #loop_accept(socket)
  end
  
  @doc "buffered connection processing"
  def serve(client, buffer) do
    Logger.info "serve:#{inspect [client,buffer]}"
    case :gen_tcp.recv(socket, 0) do
      {:error, reason} ->
        Logger.info("Socket terminating: #{inspect reason}")
      {:ok, data} ->
        buffer = maybe_recreate_buffer(buffer)
        Buffer.hold(buffer, data)
        serve(client, buffer) # loop
    end
  end
  
end
