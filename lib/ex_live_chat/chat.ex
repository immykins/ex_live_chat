defmodule ExLiveChat.Chat do
  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(ExLiveChat.PubSub, @topic)
  end

  # def subscribe(user_id) do
  #   Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{user_id}")
  # end

  def say(params) do
    notify_subscribers(:say, params)
  end

  def is_typing(name) do
    notify_subscribers(:is_typing, name)
  end

  # :say, %{"name" => name, "chat" => chat}
  defp notify_subscribers(event, params \\ %{}) do
    Phoenix.PubSub.broadcast(ExLiveChat.PubSub, @topic, {__MODULE__, event, params})
  end
end
