defmodule Tasktracker.Post.Assignment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Post.Assignment
  alias Tasktracker.Assignments.Timeblock

  schema "assignments" do
    field :complete, :boolean, default: false
    field :description, :string
    field :headline, :string
    field :hours, :integer
    field :minutes, :integer
    belongs_to :receiver, Tasktracker.Accounts.User
    belongs_to :publisher, Tasktracker.Accounts.User
    # has_many :time_block, Timeblock, foreign_key: :assignment_id
    # has_many :blocks, through: [:time_block, :assignment_id]
    timestamps()
  end

  @doc false
  #change cast
  def changeset(%Assignment{} = assignment, attrs) do
    assignment
    |> cast(attrs, [:publisher_id, :receiver_id, :headline, :description, :complete, :hours, :minutes])
    |> validate_required([:publisher_id, :receiver_id, :headline, :description, :complete, :hours, :minutes])
  end
end
