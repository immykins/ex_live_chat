defmodule ExLiveChat.ChatManager do
  use GenServer

  # client API

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def is_chatting() do
    # timer = Process.send_after
    GenServer.cast(__MODULE__, :chatting)
  end

  # private server callbacks

  # todo: load in old state from redis
  @impl true
  def init(_state) do
    {:ok, %{timer: nil}}
  end

  @impl true
  def handle_cast(:chatting, %{timer: timer}) do
    if timer, do: :timer.cancel(timer)

    timer = Process.send_after(self(), :not_chatting, 5_000)
    {:noreply, %{timer: timer}}
  end

  @impl true
  def handle_info(:not_chatting, %{timer: timer}) do
    :timer.cancel(timer)

    {:noreply, %{timer: nil}}
  end
end
