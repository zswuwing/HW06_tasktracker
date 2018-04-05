defmodule Tasktracker.Relationship.Supervision do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Relationship.Supervision


  schema "supervisions" do
    belongs_to :supervisor, User
    belongs_to :underling, User
    # field :superviosr_id, :id
    # field :underling_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Supervision{} = supervision, attrs) do
    supervision
    |> cast(attrs, [:supervisor_id, :underling_id])
    |> validate_required([:supervisor_id, :underling_id])
  end
end
