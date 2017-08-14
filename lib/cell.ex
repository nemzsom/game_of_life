defmodule GameOfLife.Cell do

  def start_link({x, y}, state) do
    Agent.start_link(fn -> state end, name: cell_name({x, y}))
  end

  def get({x, y}) do
    case GenServer.whereis(cell_name({x, y})) do
      nil -> :dead
      pid -> Agent.get(pid, &(&1))
    end
  end

  def update({x, y}, state) do
    Agent.update(cell_name({x, y}), fn(_old_state) -> state end)
  end

  def next_gen({x, y}) do
    next_gen(get({x, y}), number_of_live_neighbour({x, y}))
  end

  defp number_of_live_neighbour({x, y}) do
    for n <- x-1..x+1,
             m <- y-1..y+1,
             n != x || m != y do
               get({n, m})
             end
    |> Enum.count(fn(state) -> state == :live end)
  end

  defp next_gen(:live, live_neighbours) when live_neighbours < 2, do: :dead
  defp next_gen(:live, live_neighbours) when live_neighbours > 3, do: :dead
  defp next_gen(:live, _live_neighbours), do: :live
  defp next_gen(:dead, live_neighbours) when live_neighbours == 3, do: :live
  defp next_gen(:dead, _live_neighbours), do: :dead

  defp cell_name({x, y}) do
    String.to_atom("cell_#{x}_#{y}")
  end
end