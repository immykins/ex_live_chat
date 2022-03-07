defmodule ExLiveChat.Chat do
  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  # def subscribe(user_id) do
  #   Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{user_id}")
  # end
end
