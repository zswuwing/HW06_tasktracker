defmodule Tasktracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :assignment_id, references(:assignments, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:timeblocks, [:assignment_id])
  end
end
