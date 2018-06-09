defmodule Hello do

def say(), do: say(:World)
def say(what), do: "Hello #{what}"

end
