use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :tasktracker, TasktrackerWeb.Endpoint,
  secret_key_base: "RNEneAzLhV9ximFk+zwilCSRznZiAi9YkhwjPJF8ipqT6XHKsp5pNCIiFy3quKq1",
  url: [host: "localhost", port: 5102]

# Configure your database
config :tasktracker, Tasktracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "tasktracker",
  password: "123456",
  database: "tasktracker_dev",
  pool_size: 10
