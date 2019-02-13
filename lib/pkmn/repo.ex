defmodule Pkmn.Repo do
  use Ecto.Repo,
    otp_app: :pkmn,
    adapter: Ecto.Adapters.Postgres
end
