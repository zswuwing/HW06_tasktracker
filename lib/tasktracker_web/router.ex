defmodule TasktrackerWeb.Router do
  use TasktrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Below the pipeline
  def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    user = Tasktracker.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  scope "/", TasktrackerWeb do
    pipe_through :browser # Use the default browser stack
    resources "/assignments", AssignmentController
    get "/", PageController, :index
    resources "/users", UserController
    resources "/flags", FlagController
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
    get "/feed", PageController, :feed

  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TasktrackerWeb do
    pipe_through :api
    resources "/supvisions", SupervisionController, except: [:new, :edit]
    resources "/timeblocks", TimeblockController, except: [:new, :edit]
  end
end
