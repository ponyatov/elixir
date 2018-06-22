defmodule Buffer do
	@moduledoc """
	Buffer the data received to parse out
	
	originals:
	https://robots.thoughtbot.com/playing-with-sockets-and-processes-in-elixir
	https://gist.github.com/jyurek/0c1aac357cbcc8f52007627e8658d724
	"""
	
	use GenServer
	require Logger
	
	@initial_state ""
	
	def create do
	  GenServer.start_link(__MODULE__, @initial_state)
	end
	
	def init(args) do
	  {:ok, args}
	end
	
end
