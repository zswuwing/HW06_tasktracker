defmodule Tasktracker.Post do
  @moduledoc """
  The Post context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo
  alias Tasktracker.Accounts
  alias Tasktracker.Post.Assignment
  alias Tasktracker.Assignments.Timeblock

  @doc """
  Returns the list of assignments.
  ## Examples
      iex> list_assignments()
      [%Assignment{}, ...]
  """
  def list_assignments do
    Repo.all(Assignment)
    |> Repo.preload(:publisher)
    |> Repo.preload(:receiver)

  end

  def list_assignments_by_publisher_id(id) do
    Repo.all(from a in Assignment,
      where: a.publisher_id == ^id)
    |> Repo.preload(:publisher)
    |> Repo.preload(:receiver)
    |> List.wrap

  end

  @doc """
  Gets a single assignment.
  Raises `Ecto.NoResultsError` if the Assignment does not exist.
  ## Examples
      iex> get_assignment!(123)
      %Assignment{}
      iex> get_assignment!(456)
      ** (Ecto.NoResultsError)
  """
  def get_assignment!(id) do
    Repo.get!(Assignment, id)
    |> Repo.preload(:publisher)
    |> Repo.preload(:receiver)

  end

  @doc """
  Creates a assignment.
  ## Examples
      iex> create_assignment(%{field: value})
      {:ok, %Assignment{}}
      iex> create_assignment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_assignment(attrs \\ %{}) do

    %Assignment{}
    |> Assignment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assignment.
  ## Examples
      iex> update_assignment(assignment, %{field: new_value})
      {:ok, %Assignment{}}
      iex> update_assignment(assignment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_assignment(%Assignment{} = assignment, attrs) do
    assignment
    |> Assignment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Assignment.
  ## Examples
      iex> delete_assignment(assignment)
      {:ok, %Assignment{}}
      iex> delete_assignment(assignment)
      {:error, %Ecto.Changeset{}}
  """
  def delete_assignment(%Assignment{} = assignment) do
    Repo.delete(assignment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assignment changes.
  ## Examples
      iex> change_assignment(assignment)
      %Ecto.Changeset{source: %Assignment{}}
  """
  def change_assignment(%Assignment{} = assignment) do
    Assignment.changeset(assignment, %{})
  end

  def get_timeblocks_by_assignment(id) do
    Repo.all(from t in Timeblock,
      where: t.assignment_id == ^id)
  end

  def block_map_for() do
    Repo.all(from u in Timeblock,
      where: u.start_time == u.end_time)
      |> Enum.map(&({&1.assignment_id, &1.id}))
      |> Enum.into(%{})
  end


  #disscussed with cheng zeng
  def calc_time_block(id) do
    Repo.all(from f in Timeblock,
      where: f.assignment_id == ^id)
    |> Enum.map(fn x ->
      DateTime.diff(x.end_time, x.start_time, :second)
    end)
    |> Enum.sum
    |> (fn x ->
      hour = div(x,3600)
      minutes = div(x - hour * 3600, 60)
      {id, [hour,minutes]}
    end).()
  end






end
