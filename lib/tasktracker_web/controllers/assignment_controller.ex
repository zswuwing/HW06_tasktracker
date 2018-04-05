defmodule TasktrackerWeb.AssignmentController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Post
  alias Tasktracker.Post.Assignment

  action_fallback TasktrackerWeb.FallbackController

  def index(conn, _params) do
    assignments = Post.list_assignments()
    render(conn, "index.json", assignments: assignments)
  end

  def create(conn, %{"assignment" => assignment_params}) do
    IO.inspect(assignment_params)
    with {:ok, %Assignment{} = assignment} <- Post.create_assignment(assignment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", assignment_path(conn, :show, assignment))
      |> render("show.json", assignment: assignment)
    end
  end

  def show(conn, %{"id" => id}) do
    assignment = Post.get_assignment!(id)
    render(conn, "show.json", assignment: assignment)
  end

  def update(conn, %{"id" => id, "assignment" => assignment_params}) do
    assignment = Post.get_assignment!(id)

    with {:ok, %Assignment{} = assignment} <- Post.update_assignment(assignment, assignment_params) do
      render(conn, "show.json", assignment: assignment)
    end
  end

  def delete(conn, %{"id" => id}) do
    assignment = Post.get_assignment!(id)
    with {:ok, %Assignment{}} <- Post.delete_assignment(assignment) do
      send_resp(conn, :no_content, "")
    end
  end
end
