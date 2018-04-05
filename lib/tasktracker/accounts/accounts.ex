defmodule Tasktracker.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo
  alias Tasktracker.Accounts

  alias Tasktracker.Accounts.User

  @doc """
  Returns the list of users.
  ## Examples
      iex> list_users()
      [%User{}, ...]
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.
  Raises `Ecto.NoResultsError` if the User does not exist.
  ## Examples
      iex> get_user!(123)
      %User{}
      iex> get_user!(456)
      ** (Ecto.NoResultsError)
  """
  def get_user!(id), do: Repo.get!(User, id)

  # def get_and_auth_user(email, password) do
  #   IO.inspect(password)
  #   Repo.one(
  #     from u in User,
  #     where: u.email == ^email)
  #   |> Comeonin.Argon2.check_pass(password)
  #
  # end

  # def get_and_auth_user(email, password) do
  #   user = Accounts.get_user_by_email(email)
  #   case Comeonin.Argon2.check_pass(user, password) do
  #     {:ok, user} -> user
  #     _else       -> nil
  #   end
  # end
  def get_and_auth_user(email, password) do
    user = Repo.one(
      from u in User,
      where: u.email == ^email)
    |>Comeonin.Argon2.check_pass(password, [hash_key: :pass_hash])
  end

  @doc """
  Creates a user.
  ## Examples
      iex> create_user(%{field: value})
      {:ok, %User{}}
      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_user(attrs \\ %{}) do
    pass_hashed = Comeonin.Argon2.hashpwsalt(attrs["pass_hash"])
    attrs = attrs
    |> Map.put("pass_hash", pass_hashed)
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()

  end

  @doc """
  Updates a user.
  ## Examples
      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}
      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.
  ## Examples
      iex> delete_user(user)
      {:ok, %User{}}
      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  ## Examples
      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}
  """
   # We want a non-bang variant
  def get_user(id), do: Repo.get(User, id)

  # And we want by-email lookup
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end



end
