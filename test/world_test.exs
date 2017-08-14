defmodule GameOfLife.WorldTest do
  use ExUnit.Case, async: false
  alias GameOfLife.World

  test "init actual state" do
    world = [[:dead, :live, :dead],
             [:live, :dead, :live]]
    {:ok, pid} = World.start_link(world)
    assert World.actual_state(pid) == world
  end

  test "change state" do
    world = [[:dead, :live, :dead],
             [:live, :dead, :live]]
    {:ok, pid} = World.start_link(world)

    update = [[:live, :dead, :live],
              [:dead, :live, :dead]]
    World.update_state(pid, update)
    assert World.actual_state(pid) == update
  end

  test "calcluate next generation" do
    world = [[:live, :live, :live]]
    {:ok, pid} = World.start_link(world)

    assert World.next_gen(pid) == [[:dead, :live, :dead]]
  end
end