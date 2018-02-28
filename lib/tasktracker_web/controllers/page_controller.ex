defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller
  alias Tasktracker.Post
  alias Tasktracker.Accounts
  alias Tasktracker.Assignments.Timeblock
  def index(conn, _params) do

    user_id = get_session(conn, :user_id)

    if user_id do
      #user = Accounts.get_user!(user_id)
	    assignments = Post.list_assignments
      blocks = Post.block_map_for()
      current_user = get_session(conn, :current_user)
      # discussed with cheng zeng

        timespent_for_assignments = Enum.map(assignments, fn x ->
              Post.calc_time_block(x.id)
            end)
            |> List.flatten
            |> Enum.into(%{})
            # render(conn, "index.html", tasks: tasks)
            render conn, "index.html", assignments: assignments, user_id: user_id, blocks: blocks, timespent_for_assignments: timespent_for_assignments
      # else
      #   conn
      #   |> put_status(401)
      #   |> put_view(ErrorView)
      #   |> render(:"401")
      #end

	    #render conn, "index.html", assignments: assignments, user_id: user_id, blocks: blocks
    else

    	render conn, "index.html", assignments: []
    end
  end


end
