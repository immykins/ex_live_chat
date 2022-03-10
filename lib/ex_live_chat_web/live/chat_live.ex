defmodule ExLiveChatWeb.ChatLive do
  use ExLiveChatWeb, :live_view
  use Phoenix.HTML

  # alias Phoenix.LiveView.Socket
  alias ExLiveChat.Chat

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:chat, [["immy", "meow"]])
      |> assign(:typing, false)
    }
  end

  # this can probably be moved into mount unless I need specific HTTP parameters
  def handle_params(_params, _url, socket) do
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
    # uhh make this cleaner somehow
    Chat.say(%{"name" => name, "text" => text})

    {:noreply, assign(socket, :chat, chat)}
  end

  # %{"_target" => target, "name" => name, "text" => text}
  def handle_event("change", %{"name" => name, "text" => _text}, socket) do
    IO.inspect(name)
    Chat.is_typing(name)
    {:noreply, socket}
  end

  def handle_info({Chat, [:user, :updated], _}, socket) do
    {:noreply, socket}
  end

  # def handle_event("msg", %{"" => }, socket) do
  #   msg = socket
  #   socket = assign
  #   {:noreply, socket}
  # end
end
