defmodule Tasktracker.Repo.Migrations.CreateAssignments do
  use Ecto.Migration

  def change do
    create table(:assignments) do
      add :headline, :string, null: false
      add :description, :text, null: false
      add :hours, :integer
      add :minutes, :integer
      add :complete, :boolean, default: false, null: false
      add :publisher_id, references(:users, on_delete: :delete_all), null: false
      add :receiver_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:assignments, [:publisher_id])
    create index(:assignments, [:receiver_id])
  end
end
