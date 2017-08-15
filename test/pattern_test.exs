defmodule GameOfLife.PatternTest do
  use ExUnit.Case, async: false
  alias GameOfLife.Pattern

  test "load pattern" do
    world = Pattern.load_world("block.world", {3, 3})
    assert world == [[:dead, :dead, :dead],
                     [:dead, :live, :live],
                     [:dead, :live, :live]]
  end

end