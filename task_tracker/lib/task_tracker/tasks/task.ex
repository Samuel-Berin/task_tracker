defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :timeSpent, :integer
    field :title, :string
    field :assigned_to, :string
    belongs_to :user, TaskTracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :timeSpent, :user_id, :assigned_to])
    |> validate_required([:title, :description, :completed, :timeSpent, :user_id, :assigned_to])
  end
end
