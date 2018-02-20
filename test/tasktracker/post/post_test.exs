defmodule Tasktracker.PostTest do
  use Tasktracker.DataCase

  alias Tasktracker.Post

  describe "assignments" do
    alias Tasktracker.Post.Assignment

    @valid_attrs %{complete: true, description: "some description", headline: "some headline", hours: 42, minutes: 42}
    @update_attrs %{complete: false, description: "some updated description", headline: "some updated headline", hours: 43, minutes: 43}
    @invalid_attrs %{complete: nil, description: nil, headline: nil, hours: nil, minutes: nil}

    def assignment_fixture(attrs \\ %{}) do
      {:ok, assignment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Post.create_assignment()

      assignment
    end

    test "list_assignments/0 returns all assignments" do
      assignment = assignment_fixture()
      assert Post.list_assignments() == [assignment]
    end

    test "get_assignment!/1 returns the assignment with given id" do
      assignment = assignment_fixture()
      assert Post.get_assignment!(assignment.id) == assignment
    end

    test "create_assignment/1 with valid data creates a assignment" do
      assert {:ok, %Assignment{} = assignment} = Post.create_assignment(@valid_attrs)
      assert assignment.complete == true
      assert assignment.description == "some description"
      assert assignment.headline == "some headline"
      assert assignment.hours == 42
      assert assignment.minutes == 42
    end

    test "create_assignment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Post.create_assignment(@invalid_attrs)
    end

    test "update_assignment/2 with valid data updates the assignment" do
      assignment = assignment_fixture()
      assert {:ok, assignment} = Post.update_assignment(assignment, @update_attrs)
      assert %Assignment{} = assignment
      assert assignment.complete == false
      assert assignment.description == "some updated description"
      assert assignment.headline == "some updated headline"
      assert assignment.hours == 43
      assert assignment.minutes == 43
    end

    test "update_assignment/2 with invalid data returns error changeset" do
      assignment = assignment_fixture()
      assert {:error, %Ecto.Changeset{}} = Post.update_assignment(assignment, @invalid_attrs)
      assert assignment == Post.get_assignment!(assignment.id)
    end

    test "delete_assignment/1 deletes the assignment" do
      assignment = assignment_fixture()
      assert {:ok, %Assignment{}} = Post.delete_assignment(assignment)
      assert_raise Ecto.NoResultsError, fn -> Post.get_assignment!(assignment.id) end
    end

    test "change_assignment/1 returns a assignment changeset" do
      assignment = assignment_fixture()
      assert %Ecto.Changeset{} = Post.change_assignment(assignment)
    end
  end
end
