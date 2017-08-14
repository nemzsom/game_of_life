defmodule GameOfLife do
  use Application

  def start(_type, args) do
    world = GameOfLife.Pattern.load_world("block.world",{100,100})
    {:ok, wpid} = GameOfLife.World.start_link(world)
    {:ok, dpid} = GameOfLife.Display.start_link
    {:ok, simulation} = GameOfLife.Simulator.start_link([displayPid: dpid, worldPid: wpid])
    {:ok, scheduler} = GameOfLife.Scheduler.start_link([duration: 5, receiver: simulation]) #Supervisor.start_link([{GameOfLife.Scheduler ,[duration: 1000, receiver: simulation]}], strategy: :one_for_one)
    {:ok, scheduler}
  end
end
