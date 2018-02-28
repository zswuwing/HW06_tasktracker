defmodule TasktrackerWeb.SupervisionView do
  use TasktrackerWeb, :view
  alias TasktrackerWeb.SupervisionView

  def render("index.json", %{supervisions: supervisions}) do
    %{data: render_many(supervisions, SupervisionView, "supervision.json")}
  end

  def render("show.json", %{supervision: supervision}) do
    %{data: render_one(supervision, SupervisionView, "supervision.json")}
  end

  def render("supervision.json", %{supervision: supervision}) do
    %{id: supervision.id}
  end
end
