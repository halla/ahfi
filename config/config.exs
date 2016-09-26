# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ahfi,
  ecto_repos: [Ahfi.Repo]

# Configures the endpoint
config :ahfi, Ahfi.Endpoint,
  url: [host: "localhost"],
  version: Mix.Project.config[:version],
  secret_key_base: "tMi1Ych3ztQujXTQ/Z8dPnB1WZQDzAtH8WvcxqiIzazFCe7qnUnTc8BBwZWb9d6O",
  render_errors: [view: Ahfi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ahfi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
