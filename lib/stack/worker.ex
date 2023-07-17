defmodule Stack.Worker do
  use GenServer

  def start_link(init_state, _opts \\ []) do
    GenServer.start_link(__MODULE__, init_state)
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:pop, _from, [] = state), do: {:reply, [], state}
  def handle_call(:pop, _from, [first | remaining]), do: {:reply, first, remaining}

  @impl true
  def handle_cast({:push, element}, state) do
    new_state = [element | state]
    {:noreply, new_state}
  end
end
