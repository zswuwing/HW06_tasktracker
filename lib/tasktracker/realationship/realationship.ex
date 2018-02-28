defmodule Tasktracker.Realationship do
  @moduledoc """
  The Realationship context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Realationship.Supervision

  @doc """
  Returns the list of supervisions.

  ## Examples

      iex> list_supervisions()
      [%Supervision{}, ...]

  """
  def list_supervisions do
    Repo.all(Supervision)
  end

  @doc """
  Gets a single supervision.

  Raises `Ecto.NoResultsError` if the Supervision does not exist.

  ## Examples

      iex> get_supervision!(123)
      %Supervision{}

      iex> get_supervision!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supervision!(id), do: Repo.get!(Supervision, id)

  @doc """
  Creates a supervision.

  ## Examples

      iex> create_supervision(%{field: value})
      {:ok, %Supervision{}}

      iex> create_supervision(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supervision(attrs \\ %{}) do
    %Supervision{}
    |> Supervision.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supervision.

  ## Examples

      iex> update_supervision(supervision, %{field: new_value})
      {:ok, %Supervision{}}

      iex> update_supervision(supervision, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supervision(%Supervision{} = supervision, attrs) do
    supervision
    |> Supervision.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Supervision.

  ## Examples

      iex> delete_supervision(supervision)
      {:ok, %Supervision{}}

      iex> delete_supervision(supervision)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supervision(%Supervision{} = supervision) do
    Repo.delete(supervision)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supervision changes.

  ## Examples

      iex> change_supervision(supervision)
      %Ecto.Changeset{source: %Supervision{}}

  """
  def change_supervision(%Supervision{} = supervision) do
    Supervision.changeset(supervision, %{})
  end

  def underlings_map_for(user_id) do
    Repo.all(from u in Supervision,
      where: u.supervisor_id == ^user_id)
      |> Enum.map(&({&1.underling_id, &1.id}))
      |> Enum.into(%{})
  end

  def get_manager(user_id) do
    Repo.all(from u in Supervision,
      where: u.underling_id == ^user_id)
      |> Enum.map(&({&1.underling_id, &1.supervisor_id}))
      |> Enum.into(%{})

  end

  # def get_underlings(user_id) do
  #   Repo.all(from u in Supervision,
  #     where: u.supervisor_id == ^user_id)
  #     |> Enum.map(&({&1.underling_id, &1.supervisor_id}))
  #     |> Enum.into(%{})
  # end


end
