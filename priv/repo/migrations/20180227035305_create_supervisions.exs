defmodule Tasktracker.Repo.Migrations.CreateSupervisions do
  use Ecto.Migration

  def change do
    create table(:supervisions) do
      add :supervisor_id, references(:users, on_delete: :delete_all), null: false
      add :underling_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:supervisions, [:supervisor_id])
    create index(:supervisions, [:underling_id])
  end
end
