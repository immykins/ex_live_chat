defmodule ExLiveChat.Repo do
  use Ecto.Repo,
    otp_app: :ex_live_chat,
    adapter: Ecto.Adapters.Postgres
end
