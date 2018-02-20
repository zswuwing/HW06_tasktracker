defmodule TasktrackerWeb.FlagController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Social
  alias Tasktracker.Social.Flag

  def index(conn, _params) do
    flags = Social.list_flags()
    render(conn, "index.html", flags: flags)
  end

  def new(conn, _params) do
    changeset = Social.change_flag(%Flag{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"flag" => flag_params}) do
    case Social.create_flag(flag_params) do
      {:ok, flag} ->
        conn
        |> put_flash(:info, "Flag created successfully.")
        |> redirect(to: flag_path(conn, :show, flag))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    flag = Social.get_flag!(id)
    render(conn, "show.html", flag: flag)
  end

  def edit(conn, %{"id" => id}) do
    flag = Social.get_flag!(id)
    changeset = Social.change_flag(flag)
    render(conn, "edit.html", flag: flag, changeset: changeset)
  end

  def update(conn, %{"id" => id, "flag" => flag_params}) do
    flag = Social.get_flag!(id)

    case Social.update_flag(flag, flag_params) do
      {:ok, flag} ->
        conn
        |> put_flash(:info, "Flag updated successfully.")
        |> redirect(to: flag_path(conn, :show, flag))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", flag: flag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    flag = Social.get_flag!(id)
    {:ok, _flag} = Social.delete_flag(flag)

    conn
    |> put_flash(:info, "Flag deleted successfully.")
    |> redirect(to: flag_path(conn, :index))
  end
end
