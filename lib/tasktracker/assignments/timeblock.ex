defmodule Tasktracker.Assignments.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Assignments.Timeblock
  alias Tasktracker.Post.Assignment

  schema "timeblocks" do
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    belongs_to :assignment, :Assignment

    timestamps()
  end



  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start_time, :end_time, :assignment_id])
    |> validate_required([:start_time, :end_time, :assignment_id])
  end
end
