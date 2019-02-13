# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pkmn,
  ecto_repos: [Pkmn.Repo]

# Configures the endpoint
config :pkmn, PkmnWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UF1UdjWthNH+gIG/7NYSsFHMypWT3wEsng/hXiNaWS2hWqdnVBBvHnTLHb0Rjl8R",
  render_errors: [view: PkmnWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pkmn.PubSub,
           adapter: Phoenix.PubSub.PG2]
# Configure the url to the pokeAPI
config :pkmn,
  pokeapi_url: "https://pokeapi.co/api/v2/"


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason
config :ecto, :json_library, Jason


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
