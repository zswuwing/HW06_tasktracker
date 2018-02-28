defmodule TasktrackerWeb.SupervisionController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Realationship
  alias Tasktracker.Realationship.Supervision

  action_fallback TasktrackerWeb.FallbackController

  def index(conn, _params) do
    supervisions = Realationship.list_supervisions()
    render(conn, "index.json", supervisions: supervisions)
  end

  def create(conn, %{"supervision" => supervision_params}) do
    with {:ok, %Supervision{} = supervision} <- Realationship.create_supervision(supervision_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", supervision_path(conn, :show, supervision))
      |> render("show.json", supervision: supervision)
    end
  end

  def show(conn, %{"id" => id}) do
    supervision = Realationship.get_supervision!(id)
    render(conn, "show.json", supervision: supervision)
  end

  def update(conn, %{"id" => id, "supervision" => supervision_params}) do
    supervision = Realationship.get_supervision!(id)

    with {:ok, %Supervision{} = supervision} <- Realationship.update_supervision(supervision, supervision_params) do
      render(conn, "show.json", supervision: supervision)
    end
  end

  def delete(conn, %{"id" => id}) do
    supervision = Realationship.get_supervision!(id)
    with {:ok, %Supervision{}} <- Realationship.delete_supervision(supervision) do
      send_resp(conn, :no_content, "")
    end
  end
end
