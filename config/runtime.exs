# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.

import Config

api_port = String.to_integer(System.get_env("API_PORT", "4000"))

# database_url =
#   System.get_env("DATABASE_URL") ||
#     raise """
#     environment variable DATABASE_URL is missing.
#     For example: ecto://USER:PASS@HOST/DATABASE
#     """

debug_errors = System.get_env("DEBUG_ERRORS") || false

postgres_database = case config_env() do
  :prod ->
    System.get_env("PGDATABASE", "tasks")
  :dev ->
    System.get_env("PGDATABASE", "tasks_dev")
  :test ->
    System.get_env("PGDATABASE", "tasks_test")
  _other ->
    raise """
    Unknown config environment
    """
end

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

IO.puts("DATABASE: " <> postgres_database)

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :task_manager, TaskManagerWeb.Endpoint,
  http: [
    port: api_port,
    transport_options: [socket_opts: [:inet6]]
  ],
  debug_errors: debug_errors,
  code_reloader: false,
  check_origin: false,
  live_view: [signing_salt: "UQJNWuHx"],
  secret_key_base: secret_key_base,
  server: true,
  watchers: []

if config_env() != :test do
  # Configure your database
  config :task_manager, TaskManager.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: postgres_username,
    password: postgres_password,
    database: postgres_database,
    hostname: postgres_host,
    port: postgres_port,
    migration_timestamps: [type: :utc_datetime],
    show_sensitive_data_on_connection_error: true,
    pool_size: 10
end
