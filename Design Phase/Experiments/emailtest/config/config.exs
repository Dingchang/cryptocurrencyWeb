# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :emailtest,
  ecto_repos: [Emailtest.Repo]

# Configures the endpoint
config :emailtest, EmailtestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dPLdm+T14T3/p9/cmsbD8ddnDWZnCS/yQ3KwRSoqU09gEZr+LtLm3ld2tzUfuESP",
  render_errors: [view: EmailtestWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Emailtest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configures Mailgun API
config :emailtest, mailgun_domain: "https://api.mailgun.net/v3/sandboxf1824ecaeede4b19b949ed15fce5f789.mailgun.org",
                   mailgun_key: "key-a00aa38bda70cee37527688f8dcdcb8b"
