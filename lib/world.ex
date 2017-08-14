defmodule GameOfLife.World do
  alias GameOfLife.{Row, Cell}
  use GenServer

  def start_link(world) do
    GenServer.start_link(__MODULE__, world)
  end

  def actual_state(pid) do
    GenServer.call(pid, :act_state)
  end

  def update_state(pid, update) do
    GenServer.call(pid, [update: update])
  end

  def next_gen(pid) do
    GenServer.call(pid, :next_gen)
  end

  # callbacks
  
  def init(world) do
    for {row, y} <- Enum.with_index(world),
        {state, x} <- Enum.with_index(row) do
          Cell.start_link({x, y}, state)
        end
    {:ok, {length(hd(world)), length(world)}}
  end

  def handle_call(:act_state, _from, {x_length, y_length}) do
    act_world = for_each_row_async(y_length, fn(y) -> Row.get(y, x_length) end)
    {:reply, act_world, {x_length, y_length}}
  end

  def handle_call([update: update], _from, {x_length, y_length}) do
    for {row, y} <- Enum.with_index(update), do: Row.update(y, row)
    {:reply, :ok, {x_length, y_length}}
  end

  def handle_call(:next_gen, _from, {x_length, y_length}) do
    next_gen = for_each_row_async(y_length, fn(y) -> Row.next_gen(y, x_length) end)
    {:reply, next_gen, {x_length, y_length}}
  end

  defp for_each_row_async(y_length, row_funct) do
    0..y_length-1
    |> Enum.map(fn(y) -> Task.async(fn -> row_funct.(y) end) end)
    |> Enum.map(fn(task) -> Task.await(task) end)
  end

end