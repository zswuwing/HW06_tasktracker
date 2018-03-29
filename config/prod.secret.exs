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
  secret_key_base: "qVVwtiLE28UfcOac4o6vZNTnZNlyb/ySuPib1Y2KgHG5eRANjTpY2nVmyTaI3y4z",
  url: [host: "localhost", port: 5103]

# Configure your database
config :tasktracker, Tasktracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "tasktracker",
  password: "123456",
  database: "tasktracker2_prod",
  pool_size: 10
