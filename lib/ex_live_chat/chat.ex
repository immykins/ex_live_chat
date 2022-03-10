defmodule ExLiveChat.Chat do
  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(ExLiveChat.PubSub, @topic)
  end

  # def subscribe(user_id) do
  #   Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{user_id}")
  # end

  def say(name, chat) do
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(ExLiveChat.PubSub, @topic, {__MODULE__, event, result})
    {:ok, result}
  end

  # idk could do something with this probably
  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
