use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.

postgres_database = System.get_env("PGDATABASE", "tasks_test")

postgres_host =
  System.get_env("PGHOST") ||
    raise """
    environment variable PGHOST is missing.
    """

postgres_port = String.to_integer(System.get_env("PGPORT", "5432"))

postgres_password =
  System.get_env("PGPSWD") ||
    raise """
    environment variable PGPSWD is missing.
    """

postgres_username =
  System.get_env("PGUSER") ||
    raise """
    environment variable PGUSER is missing.
    """

config :task_manager, TaskManager.Repo,
  username: postgres_username,
  password: postgres_password,
  database: postgres_database,
  hostname: postgres_host,
  port: postgres_port,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :task_manager, TaskManagerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
