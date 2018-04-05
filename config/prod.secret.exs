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
  secret_key_base: "3cDFNCKCg5WC5tbZcIK/J+fVMRWV2Z2IBvhHtXRwTcRpUPVllVzXfv2jMTiU0dUe"

# Configure your database
config :tasktracker, Tasktracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "tasktracker",
  password: "123456",
  database: "tasktracker_part3",
  pool_size: 15
