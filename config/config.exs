# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :movies_db_backend,
  ecto_repos: [MoviesDbBackend.Repo]

# Configures the endpoint
config :movies_db_backend, MoviesDbBackend.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iafB6Dvm5rxjAlZX9SHmj8W/+KlIqsu3kPUWFs8Kl0f7U8tfPClAEhuN32c6WaC7",
  render_errors: [view: MoviesDbBackend.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MoviesDbBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Algolia Search
config :algolia,
  application_id: "F1H4RHQQOS",
  api_key: "653c7e19a8a92b96935b3681becf5706"

  # Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
