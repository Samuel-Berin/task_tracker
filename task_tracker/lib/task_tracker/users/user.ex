defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :admin, :boolean, default: false
    field :name, :string

    has_many :tasks, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :admin])
    |> validate_required([:name, :admin])
  end

end
