# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasktracker.Repo.insert!(%Tasktracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# defmodule Seeds do
#   alias Tasktracker.Repo
#   alias Tasktracker.Accounts.User
#   alias Tasktracker.Posts.Assignment
#
#   def run do
#     p = Comeonin.Argon2.hashpwsalt("password1")
#     Repo.delete_all(User)
#
#     a = Repo.insert!(%User{ name: "alice", email: "alice@example.com", pass_hash: p })
#     b = Repo.insert!(%User{ name: "bob", email: "bob@example.com", pass_hash: p })
#     c = Repo.insert!(%User{ name: "carol", email: "carole@example.com", pass_hash: p })
#     d = Repo.insert!(%User{ name: "dave", email: "dave@example.com", pass_hash: p })
#
#
#   end
# end
#
# Seeds.run
