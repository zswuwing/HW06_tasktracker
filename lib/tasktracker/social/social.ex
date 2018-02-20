defmodule Tasktracker.Social do
  @moduledoc """
  The Social context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Social.Flag

  @doc """
  Returns the list of flags.

  ## Examples

      iex> list_flags()
      [%Flag{}, ...]

  """
  def list_flags do
    Repo.all(Flag)
    |> Repo.preload(:user)
  end

  

  @doc """
  Gets a single flag.

  Raises `Ecto.NoResultsError` if the Flag does not exist.

  ## Examples

      iex> get_flag!(123)
      %Flag{}

      iex> get_flag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flag!(id) do
    Repo.get!(Flag, id)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a flag.

  ## Examples

      iex> create_flag(%{field: value})
      {:ok, %Flag{}}

      iex> create_flag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flag(attrs \\ %{}) do
    %Flag{}
    |> Flag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flag.

  ## Examples

      iex> update_flag(flag, %{field: new_value})
      {:ok, %Flag{}}

      iex> update_flag(flag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flag(%Flag{} = flag, attrs) do
    flag
    |> Flag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Flag.

  ## Examples

      iex> delete_flag(flag)
      {:ok, %Flag{}}

      iex> delete_flag(flag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flag(%Flag{} = flag) do
    Repo.delete(flag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flag changes.

  ## Examples

      iex> change_flag(flag)
      %Ecto.Changeset{source: %Flag{}}

  """
##change
  def change_flag(%Flag{} = flag) do
   
    Flag.changeset(flag, %{})
  end
end
