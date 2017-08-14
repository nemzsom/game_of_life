defmodule GameOfLife.Scheduler do
  use GenServer

  defmodule ScheduledEvent, do: defstruct schedulerPid: ""

  def start_link([duration: arg,receiver: pid]) do
    GenServer.start_link(__MODULE__, [duration: arg,receiver: pid])
  end

  def init(args) do
    IO.inspect(args)
    schedule_work(args) # Schedule work to be performed at some point
    {:ok, args}
  end

  def handle_info(:work, args) do
    # Do the work you desire here
    receiver = args[:receiver]
    GenServer.cast(receiver, %ScheduledEvent{schedulerPid: self()})
    schedule_work(args) # Reschedule once more
    {:noreply, args}
  end

  # def handle_cast(%ScheduledEvent{schedulerPid: scheduler}, state) do
  #   IO.puts("handle_cast:")
  #   IO.inspect(scheduler)
  #   IO.inspect(state)
  #   IO.puts("Scheduler stopped:" <> inspect(scheduler))
  #   {:noreply, state}
  # end

  defp schedule_work(args) do
    IO.puts("schedule_work:")
    IO.inspect(args)
    Process.send_after(self(), :work, args[:duration])
  end

end