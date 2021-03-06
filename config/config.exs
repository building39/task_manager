# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :task_manager,
  ecto_repos: [TaskManager.Repo]

# Configures the endpoint
config :task_manager, TaskManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6Gni+WAdPpshvrHSqrnxKaiwYl2K0E6C0oU6alI5vQMC1Cs42S3qhm58JSTk1x11",
  render_errors: [view: TaskManagerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TaskManager.PubSub,
  live_view: [signing_salt: "M+rwejnB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
