defmodule GameOfLife.World do
  alias GameOfLife.Cell
  use GenServer
  
  def init(world) do
    for {row, y} <- Enum.with_index(world),
        {state, x} <- Enum.with_index(row) do
          Cell.start_link({x, y}, state)
        end
  end
end