defmodule Tasktracker.RealationshipTest do
  use Tasktracker.DataCase

  alias Tasktracker.Realationship

  describe "supervisions" do
    alias Tasktracker.Realationship.Supervision

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def supervision_fixture(attrs \\ %{}) do
      {:ok, supervision} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Realationship.create_supervision()

      supervision
    end

    test "list_supervisions/0 returns all supervisions" do
      supervision = supervision_fixture()
      assert Realationship.list_supervisions() == [supervision]
    end

    test "get_supervision!/1 returns the supervision with given id" do
      supervision = supervision_fixture()
      assert Realationship.get_supervision!(supervision.id) == supervision
    end

    test "create_supervision/1 with valid data creates a supervision" do
      assert {:ok, %Supervision{} = supervision} = Realationship.create_supervision(@valid_attrs)
    end

    test "create_supervision/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Realationship.create_supervision(@invalid_attrs)
    end

    test "update_supervision/2 with valid data updates the supervision" do
      supervision = supervision_fixture()
      assert {:ok, supervision} = Realationship.update_supervision(supervision, @update_attrs)
      assert %Supervision{} = supervision
    end

    test "update_supervision/2 with invalid data returns error changeset" do
      supervision = supervision_fixture()
      assert {:error, %Ecto.Changeset{}} = Realationship.update_supervision(supervision, @invalid_attrs)
      assert supervision == Realationship.get_supervision!(supervision.id)
    end

    test "delete_supervision/1 deletes the supervision" do
      supervision = supervision_fixture()
      assert {:ok, %Supervision{}} = Realationship.delete_supervision(supervision)
      assert_raise Ecto.NoResultsError, fn -> Realationship.get_supervision!(supervision.id) end
    end

    test "change_supervision/1 returns a supervision changeset" do
      supervision = supervision_fixture()
      assert %Ecto.Changeset{} = Realationship.change_supervision(supervision)
    end
  end
end
