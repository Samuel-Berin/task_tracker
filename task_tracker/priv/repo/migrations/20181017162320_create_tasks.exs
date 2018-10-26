defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do

    create table(:timeblock) do
      add :start, :string, default: "01/01/2000 00:00:00", null: false
      add :end, :string, default: "01/01/2000 00:00:00", null: false


      timestamps()
    end


    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :completed, :boolean, default: false, null: false
      add :assigned_to, :integer

      timestamps()
    end

    alter table(:timeblock) do
      add :task_id, references(:tasks, on_delete: :nothing)
    end

    alter table(:tasks) do
      # Migration changes from Nat's Lecture 12
      add :user_id, references(:users, on_delete: :delete_all)
      add :timeblock_id, references(:timeblock, on_delete: :delete_all)
    end

    create index(:timeblock, [:task_id])
    create index(:tasks, [:user_id])
  end
end
