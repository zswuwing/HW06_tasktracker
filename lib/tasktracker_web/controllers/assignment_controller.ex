defmodule TasktrackerWeb.AssignmentController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Post
  alias Tasktracker.Accounts
  alias Tasktracker.Post.Assignment
  alias Tasktracker.Assignments.Assignments

  def index(conn, _params) do
  #  assignments = Post.list_assignments()
    current_user = conn.assigns[:current_user]
    ## discussed with cheng zeng
    if current_user do
      assignments = Post.list_assignments_by_publisher_id(current_user.id)
      time_block = Enum.map(assignments, fn x ->
        Post.calc_time_block(x.id)
      end)
      |> List.flatten
      |> Enum.into(%{})
      # render(conn, "index.html", tasks: tasks)
      render(conn, "index.html", assignments: assignments, time_block: time_block)
    else
      conn
      |> put_status(401)
      |> put_view(ErrorView)
      |> render(:"401")
    end

    #render(conn, "index.html", assignments: assignments)
  end

  def new(conn, _params) do
    changeset = Post.change_assignment(%Assignment{})
    current_user = conn.assigns[:current_user]
    render(conn, "new.html", changeset: changeset, assignment: nil)
  end

  def create(conn, %{"assignment" => assignment_params}) do
    ##
    current_user = conn.assigns[:current_user]
    case Post.create_assignment(Map.put(assignment_params,"publisher_id",current_user.id)) do
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
    #blocks = Tasktracker.Assignments.Assignments.get_timeblocks_for(id)
    current_user = conn.assigns[:current_user]
    if current_user do

        blocks = Post.get_timeblocks_by_assignment(id)
        timespent_for_assignments = Post.calc_time_block(id)
        render(conn, "show.html", assignment: assignment, blocks: blocks, timespent_for_assignments: timespent_for_assignments)
    end

    # conn
    # |> put_status(401)
    # |> put_view(ErrorView)
    # |> render(:"401")

  end

  def edit(conn, %{"id" => id}) do
    assignment = Post.get_assignment!(id)
    changeset = Post.change_assignment(assignment)
    user_id = get_session(conn, :user_id)
    all_users = Accounts.list_users

    current_user = conn.assigns[:current_user]
    if current_user.id == user_id do

        blocks = Post.get_timeblocks_by_assignment(id)
        timespent_for_assignments = Post.calc_time_block(id)
        render(conn, "edit.html", assignment: assignment, blocks: blocks, timespent_for_assignments: timespent_for_assignments, changeset: changeset)
    else
      render(conn, "edit.html", assignment: assignment, changeset: changeset)
    end




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
