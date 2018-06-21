defmodule ErListener do
  @moduledoc """
  ErTelecom application socket listener for ThingPark downlink http://:8001
  
  see manual on writing socket server in Elixir:
  
  https://robots.thoughtbot.com/playing-with-sockets-and-processes-in-elixir
  
  """
  
  require Logger

  @doc "listen on selected port"
  def start(port\\8001) do
    spawn fn ->
      case :gen_tcp.listen(port,[]) do
        {:ok,socket} ->
          IO.inspect {:ok,socket}
        {:error,reason} ->
          IO.inspect {:error,reason}
      end
    end
  end
  
end
