defmodule GameOfLife do
  use Application

  def start(_type, args) do
    main(args)
    # temporary workaround for return value
    Task.start(fn -> IO.puts("app started") end)
  end

  def main(_args \\ []) do
    IO.puts "start app"
  end
end
