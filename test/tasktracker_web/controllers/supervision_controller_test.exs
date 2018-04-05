defmodule TasktrackerWeb.SupervisionControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.Relationship
  alias Tasktracker.Relationship.Supervision

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:supervision) do
    {:ok, supervision} = Relationship.create_supervision(@create_attrs)
    supervision
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all supervisions", %{conn: conn} do
      conn = get conn, supervision_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create supervision" do
    test "renders supervision when data is valid", %{conn: conn} do
      conn = post conn, supervision_path(conn, :create), supervision: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, supervision_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, supervision_path(conn, :create), supervision: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update supervision" do
    setup [:create_supervision]

    test "renders supervision when data is valid", %{conn: conn, supervision: %Supervision{id: id} = supervision} do
      conn = put conn, supervision_path(conn, :update, supervision), supervision: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, supervision_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, supervision: supervision} do
      conn = put conn, supervision_path(conn, :update, supervision), supervision: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete supervision" do
    setup [:create_supervision]

    test "deletes chosen supervision", %{conn: conn, supervision: supervision} do
      conn = delete conn, supervision_path(conn, :delete, supervision)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, supervision_path(conn, :show, supervision)
      end
    end
  end

  defp create_supervision(_) do
    supervision = fixture(:supervision)
    {:ok, supervision: supervision}
  end
end
