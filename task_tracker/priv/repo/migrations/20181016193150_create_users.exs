defmodule TaskTracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :admin, :boolean, default: false, null: false
      add :manager, :integer

      timestamps()
    end

  end
end
