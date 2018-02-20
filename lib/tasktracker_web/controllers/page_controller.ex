defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller
  alias Tasktracker.Post
  def index(conn, _params) do
    user_id = get_session(conn, :user_id)
    if user_id do
	assignments = Post.list_assignments
	render conn, "index.html", assignments: assignments, user_id: user_id
    else
	
    	render conn, "index.html", assignments: []
    end
  end
  

end
