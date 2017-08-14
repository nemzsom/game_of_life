defmodule GameOfLife.CellTest do
  use ExUnit.Case, async: true
  alias GameOfLife.{Cell, World}

  test "store and retrieve cell state by coordinates" do
    Cell.start_link({0, 0}, :live)
    assert Cell.get({0, 0}) == :live

    Cell.update({0, 0}, :dead)
    assert Cell.get({0, 0}) == :dead
  end

  test "non existing cells are dead" do
    assert Cell.get({1, 1}) == :dead
  end

  test "Cell can handle negative coordinates" do
    assert Cell.get({-1, -1}) == :dead
  end

  test "Any live cell with fewer than two live neighbors dies, as if caused by underpopulation" do
    [[:dead, :dead, :dead],
     [:live, :live, :dead],
     [:dead, :dead,  :dead]]
    |> World.init

    assert next_gen(0..2, 0..2) == [[:dead, :dead, :dead],
                                    [:dead, :dead, :dead],
                                    [:dead, :dead, :dead]]
  end

  test "Any live cell with more than three live neighbors dies, as if by overcrowding" do
    [[:live, :live, :live],
     [:live, :live, :live],
     [:live, :live, :live]]
    |> World.init

    assert next_gen(0..2, 0..2) == [[:live, :dead, :live],
                                    [:dead, :dead, :dead],
                                    [:live, :dead, :live]]
  end


  test "Any live cell with two or three live neighbors lives on to the next generation" do
    [[:live, :live, :dead],
     [:live, :live, :live],
     [:dead, :dead, :live]]
    |> World.init

    assert next_gen(0..2, 0..2) == [[:live, :dead, :live],
                                    [:live, :dead, :live],
                                    [:dead, :dead, :live]]
  end

  test "Any dead cell with exactly three live neighbors becomes a live cell" do
    [[:dead, :live, :dead],
     [:live, :live, :dead],
     [:dead, :live, :dead]]
    |> World.init

    assert next_gen(0..2, 0..2) == [[:live, :live, :dead],
                                    [:live, :live, :live],
                                    [:live, :live, :dead]]
  end

  defp next_gen(xRange, yRange) do
    (for y <- yRange, x <- xRange, do: Cell.next_gen({x, y}))
    |> Enum.chunk(Enum.count(xRange))
  end
end