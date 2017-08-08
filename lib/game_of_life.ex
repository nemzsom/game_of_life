defmodule GameOfLife do
  use Application

  def start(_type, _args) do
    main(_args)
  end

  def main(_args \\ []) do
    IO.puts "start app"
  end
end
