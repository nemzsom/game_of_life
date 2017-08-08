defmodule GameOfLife.Consol do
  alias Drawille.Canvas, as: Canvas

  def testConsole() do
    canvas = (for x <- 1..100,
        y <- 1..100,
        do: {x, y})
    |> Enum.reduce(Canvas.new, fn({x, y}, canvas) -> Canvas.set(canvas, x, y) end)
    Canvas.frame(canvas)
    {x, _y} = canvas.down_right
    IO.puts x
    x
  end
end