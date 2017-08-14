defmodule GameOfLife.Consol.Calibrate do
  alias Drawille.Canvas, as: Canvas

  def printPatterns() do
    (for x <- 1..100,
        y <- 1..100,
        do: {x, y})
    |> Enum.reduce(Canvas.new, fn({x, y}, canvas) -> Canvas.set(canvas, x, y) end)
    |> Canvas.frame
    Drawille.Examples.Circular.test1()
    Drawille.Examples.Circular.test2()
  end
end