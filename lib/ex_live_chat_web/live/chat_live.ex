defmodule ExLiveChatWeb.ChatLive do
  use ExLiveChatWeb, :live_view
  use Phoenix.HTML

  # alias Phoenix.LiveView.Socket
  alias ExLiveChat.Chat

  def mount(_params, _session, socket) do
    socket = assign(socket, :chat, [["immy", "meow"]])
    # socket = assign(socket, %{message: "msg"}, [])
    # socket = assign(socket, )
    socket = assign(socket, :typing, false)
    {:ok, socket}
  end

  # this can probably be moved into mount unless I need specific HTTP parameters
  def handle_params(%{"id" => _id}, _url, socket) do
    if connected?(socket), do: Chat.subscribe()
    {:noreply, socket}
  end

  def render(assigns) do
    ExLiveChatWeb.PageView.render("chat.html", assigns)
  end

  # def handle_event("press", _, socket) do
  #   socket = assign(socket, :idk, socket.assigns.idk + 10)
  #   {:noreply, socket}
  # end

  def handle_event("say", %{"name" => name, "text" => text}, socket) do
    # chat = [[name, text] | socket.assigns.chat]
    chat = socket.assigns.chat
    IO.inspect(chat)
    Chat.say()

    {:noreply, assign(socket, :chat, chat)}
  end

  # %{"_target" => target, "name" => name, "text" => text}
  def handle_event("change", something, socket) do
    IO.inspect(something)
    {:noreply, socket}
  end

  # def handle_event("msg", %{"" => }, socket) do
  #   msg = socket
  #   socket = assign
  #   {:noreply, socket}
  # end
end
