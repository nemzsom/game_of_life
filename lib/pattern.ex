defmodule GameOfLife.Pattern do
  
  def load_world(path, {x_size, y_size}) do
    live_cells = live_cells(path)
    0..y_size-1
    |> Enum.map(fn(y) -> Enum.map(0..x_size-1, fn(x) -> cell_state({x, y}, live_cells) end) end)
  end

  defp cell_state({x, y}, live_cells) do
    case MapSet.member?(live_cells, {x, y}) do
      true -> :live
      false -> :dead
    end
  end

  defp live_cells(path) do
    {:ok, file} = File.read("patterns/" <> path)
    String.split(file, "\n")
    |> Enum.map(fn(row) -> String.graphemes(row) end)
    |> Enum.with_index
    |> Enum.map(fn({row, row_index}) -> live_index(row, row_index) end)
    |> Enum.reduce(fn(row_set, global_set) -> MapSet.union(row_set, global_set) end)
  end

  defp live_index(row, row_index) do
    row
    |> Enum.map(fn(char) -> Regex.match?(~r/\S/, char) end)
    |> Enum.with_index
    |> Enum.reduce(MapSet.new, fn({live, i}, set) -> if live do MapSet.put(set, {i, row_index}) else set end end)
  end
end