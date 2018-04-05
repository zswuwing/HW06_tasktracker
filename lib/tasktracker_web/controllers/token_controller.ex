defmodule TasktrackerWeb.TokenController do
  use TasktrackerWeb, :controller
  alias Tasktracker.Accounts.User

  action_fallback TasktrackerWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    IO.inspect(password)
    with {:ok, %User{} = user} <- Tasktracker.Accounts.get_and_auth_user(email, password) do
      token = Phoenix.Token.sign(conn, "auth token", user.id)
      conn
      |> put_status(:created)
      |> render("token.json", user: user, token: token)
    end
  end
end
