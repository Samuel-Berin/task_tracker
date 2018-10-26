defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string
    field :assigned_to, :integer
    belongs_to :user, TaskTracker.Users.User
    has_many :tasks, TaskTracker.Tasks.Task
    has_one :timeblock, TaskTracker.Timeblocks.Timeblock

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :user_id, :assigned_to])
    |> validate_required([:title, :description, :completed, :user_id, :assigned_to])
  end
end
