defmodule GameOfLife.Simulator do
  use GenServer
  alias GameOfLife.{Display, World}
  alias GameOfLife.Scheduler.ScheduledEvent

  def start_link([displayPid: dpid, worldPid: wpid]) do
    GenServer.start_link(__MODULE__, [displayPid: dpid, worldPid: wpid])
  end

#   def init([displayPid: dpid, worldPid: wpid]) do
#     {:ok, [displayPid: dpid, worldPid: wpid]}
#   end

  def handle_cast(%ScheduledEvent{schedulerPid: scheduler}, [displayPid: dpid, worldPid: wpid]) do
    # Do the work you desire here
    next_gen = World.next_gen(wpid)
    flatWorld = List.flatten(next_gen)
    if Enum.member?(flatWorld, :live) do
      Display.update(dpid, next_gen, "Generating new iteration")
      World.update_state(wpid, next_gen)
    else
      GenServer.stop(scheduler)
      IO.puts("Simulation is over everyone dead.")
    end
    {:noreply, [displayPid: dpid, worldPid: wpid]}
  end

end