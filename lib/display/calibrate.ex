defmodule GameOfLife.Display.Calibrate do
  alias Drawille.Canvas
  alias GameOfLife.Display

  def print_patterns() do
    (for x <- 1..100,
        y <- 1..100,
        do: {x, y})
    |> Enum.reduce(Canvas.new, fn({x, y}, canvas) -> Canvas.set(canvas, x, y) end)
    |> Canvas.frame
    Drawille.Examples.Circular.test1()
    Drawille.Examples.Circular.test2()
  end

  def print_world1(display) do
    world = [[:live, :dead, :live],
             [:dead, :live, :dead],
             [:live, :dead, :live]]
    Display.update(display, world, "world 1")
  end

  def print_world2(display) do
    world = [[:dead, :live, :dead],
             [:live, :live, :live],
             [:dead, :live, :dead]]
    Display.update(display, world, "world 2")
  end

  def print_repeat() do
    {:ok, display} = Display.start_link
    1..20
    |> Enum.map(fn(i) -> rem(i, 2) end)
    |> Enum.each(fn(i) -> case i do
        0 -> print_world1(display)
        1 -> print_world2(display)
      end
      :timer.sleep(200)
    end)
  end
end