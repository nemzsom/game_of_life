defmodule GameOfLife.Display do
  use GenServer
  alias Drawille.Canvas

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def update(pid, world, info) do
    GenServer.call(pid, [world: world, info: info])
  end

  # callbacks

  def init(_args) do
    {:ok, -1}
  end

  def handle_call([world: world, info: info], _from, act_line) do
    IO.puts move_up_char(act_line)
    IO.puts info
    canvas = (for {row, y} <- Enum.with_index(world),
                  {state, x} <- Enum.with_index(row),
                   state == :live, do: {x + 1, y + 1})
              |> Enum.reduce(Canvas.new, fn({x, y}, canvas) -> Canvas.set(canvas, x, y) end)
    Canvas.frame(canvas)
    {:reply, :ok, elem(canvas.down_right, 1) + 2}
  end

  defp move_up_char(lines) do
    "\e[#{lines+2}A"
  end
end