defmodule Tasktracker.RelationshipTest do
  use Tasktracker.DataCase

  alias Tasktracker.Relationship

  describe "supervisions" do
    alias Tasktracker.Relationship.Supervision

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def supervision_fixture(attrs \\ %{}) do
      {:ok, supervision} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Relationship.create_supervision()

      supervision
    end

    test "list_supervisions/0 returns all supervisions" do
      supervision = supervision_fixture()
      assert Relationship.list_supervisions() == [supervision]
    end

    test "get_supervision!/1 returns the supervision with given id" do
      supervision = supervision_fixture()
      assert Relationship.get_supervision!(supervision.id) == supervision
    end

    test "create_supervision/1 with valid data creates a supervision" do
      assert {:ok, %Supervision{} = supervision} = Relationship.create_supervision(@valid_attrs)
      assert supervision.name == "some name"
    end

    test "create_supervision/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Relationship.create_supervision(@invalid_attrs)
    end

    test "update_supervision/2 with valid data updates the supervision" do
      supervision = supervision_fixture()
      assert {:ok, supervision} = Relationship.update_supervision(supervision, @update_attrs)
      assert %Supervision{} = supervision
      assert supervision.name == "some updated name"
    end

    test "update_supervision/2 with invalid data returns error changeset" do
      supervision = supervision_fixture()
      assert {:error, %Ecto.Changeset{}} = Relationship.update_supervision(supervision, @invalid_attrs)
      assert supervision == Relationship.get_supervision!(supervision.id)
    end

    test "delete_supervision/1 deletes the supervision" do
      supervision = supervision_fixture()
      assert {:ok, %Supervision{}} = Relationship.delete_supervision(supervision)
      assert_raise Ecto.NoResultsError, fn -> Relationship.get_supervision!(supervision.id) end
    end

    test "change_supervision/1 returns a supervision changeset" do
      supervision = supervision_fixture()
      assert %Ecto.Changeset{} = Relationship.change_supervision(supervision)
    end
  end
end
