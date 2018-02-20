defmodule Tasktracker.SocialTest do
  use Tasktracker.DataCase

  alias Tasktracker.Social

  describe "flags" do
    alias Tasktracker.Social.Flag

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def flag_fixture(attrs \\ %{}) do
      {:ok, flag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_flag()

      flag
    end

    test "list_flags/0 returns all flags" do
      flag = flag_fixture()
      assert Social.list_flags() == [flag]
    end

    test "get_flag!/1 returns the flag with given id" do
      flag = flag_fixture()
      assert Social.get_flag!(flag.id) == flag
    end

    test "create_flag/1 with valid data creates a flag" do
      assert {:ok, %Flag{} = flag} = Social.create_flag(@valid_attrs)
      assert flag.body == "some body"
    end

    test "create_flag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_flag(@invalid_attrs)
    end

    test "update_flag/2 with valid data updates the flag" do
      flag = flag_fixture()
      assert {:ok, flag} = Social.update_flag(flag, @update_attrs)
      assert %Flag{} = flag
      assert flag.body == "some updated body"
    end

    test "update_flag/2 with invalid data returns error changeset" do
      flag = flag_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_flag(flag, @invalid_attrs)
      assert flag == Social.get_flag!(flag.id)
    end

    test "delete_flag/1 deletes the flag" do
      flag = flag_fixture()
      assert {:ok, %Flag{}} = Social.delete_flag(flag)
      assert_raise Ecto.NoResultsError, fn -> Social.get_flag!(flag.id) end
    end

    test "change_flag/1 returns a flag changeset" do
      flag = flag_fixture()
      assert %Ecto.Changeset{} = Social.change_flag(flag)
    end
  end
end
