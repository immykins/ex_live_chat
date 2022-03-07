defmodule ExLiveChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExLiveChat.Repo,
      # Start the Telemetry supervisor
      ExLiveChatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExLiveChat.PubSub},
      # Start the Endpoint (http/https)
      ExLiveChatWeb.Endpoint,
      # Start a worker by calling: ExLiveChat.Worker.start_link(arg)
      # {ExLiveChat.Worker, arg}
      ExLiveChat.ChatManager
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExLiveChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExLiveChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
