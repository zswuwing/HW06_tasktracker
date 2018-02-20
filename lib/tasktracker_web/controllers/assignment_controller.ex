defmodule TasktrackerWeb.AssignmentController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Post
  alias Tasktracker.Accounts
  alias Tasktracker.Post.Assignment

  def index(conn, _params) do
    assignments = Post.list_assignments()
    current_user = conn.assigns[:current_user]
    render(conn, "index.html", assignments: assignments)
  end

  def new(conn, _params) do
    changeset = Post.change_assignment(%Assignment{})
    render(conn, "new.html", changeset: changeset, assignment: nil)
  end

  def create(conn, %{"assignment" => assignment_params}) do
    
    case Post.create_assignment(assignment_params) do
      {:ok, assignment} ->
        conn
        |> put_flash(:info, "Assignment created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    assignment = Post.get_assignment!(id)
    render(conn, "show.html", assignment: assignment)
  end

  def edit(conn, %{"id" => id}) do
    assignment = Post.get_assignment!(id)
    changeset = Post.change_assignment(assignment)
    user_id = get_session(conn, :user_id)
    all_users = Accounts.list_users
    
   
    render(conn, "edit.html", assignment: assignment, changeset: changeset)
   
  end

  def update(conn, %{"id" => id, "assignment" => assignment_params}) do
    assignment = Post.get_assignment!(id)

    case Post.update_assignment(assignment, assignment_params) do
      {:ok, assignment} ->
        conn
        |> put_flash(:info, "Assignment updated successfully.")
        |> redirect(to: assignment_path(conn, :show, assignment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", assignment: assignment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    assignment = Post.get_assignment!(id)
    {:ok, _assignment} = Post.delete_assignment(assignment)

    conn
    |> put_flash(:info, "Assignment deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
