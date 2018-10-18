defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :completed, :boolean, default: false, null: false
      add :timeSpent, :integer
      add :assigned_to, :string
      # Migration changes from Nat's Lecture 12
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:tasks, [:user_id])
  end
end
