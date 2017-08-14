defmodule GameOfLife.Row do
  alias GameOfLife.Cell

  def get(y, length) do
    for x <- 0..(length - 1), do: Cell.get({x, y})
  end

  def next_gen(y, length) do
    for x <- 0..(length - 1), do: Cell.next_gen({x, y})
  end

  def update(y, row) do
    for {state, x} <- Enum.with_index(row), do: Cell.update({x, y}, state)
  end
end
