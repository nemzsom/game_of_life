defmodule GameOfLife.RowTest do
  use ExUnit.Case, async: false
  alias GameOfLife.{Row, World}

  test "A row can provide the actual state" do
    [[:live, :dead, :live]]
    |> World.init

    assert Row.get(0, 3) == [:live, :dead, :live]
  end

  test "A row can calulate the next generation" do
    [[:live, :live, :live]]
    |> World.init

    assert Row.next_gen(0, 3) == [:dead, :live, :dead]
  end

  test "A row can be updated" do
    [[:live, :dead, :live]]
    |> World.init

    Row.update(0, [:dead, :live, :dead])

    assert Row.get(0, 3) == [:dead, :live, :dead]
  end
end