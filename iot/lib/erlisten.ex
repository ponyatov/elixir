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
          Logger.info("connected on #{port}")
          accept_connection(socket)
        {:error,reason} ->
          Logger.error("listen ${port} error")
      end
    end
  end
  
  @doc "accept connection to spawning serve process"
  def accept_connection(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    spawn fn ->
      {:ok, buffer} = Buffer.create()
      Logger.info "Buffer: #{buffer}" 
    end
    # loop_accept(socket)
  end
  
end
