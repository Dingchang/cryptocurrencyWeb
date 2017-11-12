# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :crypto_tracker, CryptoTracker.Scheduler,
  jobs: [
	{"@minutely", {CryptoTracker.PriceUpdatesTask, :run, []}},
        {"@minutely", {CryptoTracker.SendNotificationsTask, :run, []}}
  ]

# General application configuration
config :crypto_tracker,
  ecto_repos: [CryptoTracker.Repo]

# Configures the endpoint
config :crypto_tracker, CryptoTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ewCxia50oTQJp4FCpKjI7jfCBG1pV1MhsHSG3ic7OQGucb4jutv7AvLLtV4CjAYW",
  render_errors: [view: CryptoTrackerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CryptoTracker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
