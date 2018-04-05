defmodule TasktrackerWeb.AssignmentView do
  use TasktrackerWeb, :view
  alias TasktrackerWeb.AssignmentView

  def render("index.json", %{assignments: assignments}) do
    %{data: render_many(assignments, AssignmentView, "assignment.json")}
  end

  def render("show.json", %{assignment: assignment}) do
    %{data: render_one(assignment, AssignmentView, "assignment.json")}
  end

  def render("assignment.json", %{assignment: assignment}) do
    %{id: assignment.id,
      headline: assignment.headline,
      description: assignment.description,
      complete: assignment.complete,
      hours: assignment.hours,
      minutes: assignment.minutes,
      receiver_id: assignment.receiver_id,
      publisher_id: assignment.publisher_id}
  end
end
