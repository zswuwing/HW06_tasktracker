defmodule TasktrackerWeb.AssignmentControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.Post
  alias Tasktracker.Post.Assignment

  @create_attrs %{complete: true, description: "some description", headline: "some headline", hours: 42, minutes: 42}
  @update_attrs %{complete: false, description: "some updated description", headline: "some updated headline", hours: 43, minutes: 43}
  @invalid_attrs %{complete: nil, description: nil, headline: nil, hours: nil, minutes: nil}

  def fixture(:assignment) do
    {:ok, assignment} = Post.create_assignment(@create_attrs)
    assignment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all assignments", %{conn: conn} do
      conn = get conn, assignment_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create assignment" do
    test "renders assignment when data is valid", %{conn: conn} do
      conn = post conn, assignment_path(conn, :create), assignment: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, assignment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "complete" => true,
        "description" => "some description",
        "headline" => "some headline",
        "hours" => 42,
        "minutes" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, assignment_path(conn, :create), assignment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update assignment" do
    setup [:create_assignment]

    test "renders assignment when data is valid", %{conn: conn, assignment: %Assignment{id: id} = assignment} do
      conn = put conn, assignment_path(conn, :update, assignment), assignment: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, assignment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "complete" => false,
        "description" => "some updated description",
        "headline" => "some updated headline",
        "hours" => 43,
        "minutes" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, assignment: assignment} do
      conn = put conn, assignment_path(conn, :update, assignment), assignment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete assignment" do
    setup [:create_assignment]

    test "deletes chosen assignment", %{conn: conn, assignment: assignment} do
      conn = delete conn, assignment_path(conn, :delete, assignment)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, assignment_path(conn, :show, assignment)
      end
    end
  end

  defp create_assignment(_) do
    assignment = fixture(:assignment)
    {:ok, assignment: assignment}
  end
end
