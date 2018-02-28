defmodule Tasktracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :admin, :boolean, default: false, null: false
      add :manager, :boolean, default: false, null: false

      timestamps()
    end

  end
end
