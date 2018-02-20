defmodule Tasktracker.Social.Flag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Flag


  schema "flags" do
    field :body, :string
    belongs_to :user, Tasktracker.Accounts.User
    

    timestamps()
  end

  @doc false
  def changeset(%Flag{} = flag, attrs) do
    flag
    |> cast(attrs, [:body, :user_id])
    |> validate_required([:body, :user_id])
  end
end
