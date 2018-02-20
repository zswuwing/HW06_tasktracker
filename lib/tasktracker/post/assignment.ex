defmodule Tasktracker.Post.Assignment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Post.Assignment


  schema "assignments" do
    field :complete, :boolean, default: false
    field :description, :string
    field :headline, :string
    field :hours, :integer
    field :minutes, :integer
    belongs_to :publisher, Tasktracker.Accounts.User
    belongs_to :receiver, Tasktracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Assignment{} = assignment, attrs) do
    assignment
    |> cast(attrs, [:publisher_id, :receiver_id, :headline, :description, :hours, :minutes, :complete])
    |> validate_required([:publisher_id, :receiver_id, :headline, :description, :hours, :minutes, :complete])
  end
end
