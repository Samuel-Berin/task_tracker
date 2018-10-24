defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller
  import Ecto.Changeset
  import TaskTracker.Users.User

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task

  def index(conn, _params) do
    id = get_session(conn, :user_id)
    tasks = Tasks.get_tasks_created_by(id)
    tasks2 = Tasks.get_tasks_for(id)
    tasks = tasks ++ tasks2
    tasks = Enum.uniq(tasks)
    users = getUsersAsMapCreatedByManager(conn)

    render(conn, "index.html", tasks: tasks, users: users)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    usersAsDropdown = getUsersCreatedByManager(conn)
    render(conn, "new.html", changeset: changeset, availableUsers: usersAsDropdown)
  end

  def getUsersCreatedByManager(conn) do
    id = get_session(conn, :user_id)
    users = TaskTracker.Users.get_users_created_by_manager_id(id)
    users = getUserListAsTuples(users)
  end

  def getUserListAsTuples(users) do
    usersAsDropdown = []
    usersAsDropdown = Enum.reduce users, [], fn user, acc ->
      userName = user.name
      userTuple = {userName, user.id}
      [userTuple | acc]
    end
  end

  def getUserListAsMap(users) do
    usersAsMap = Enum.reduce users, %{}, fn user, acc ->
      userID = user.id
      Map.put(acc, user.id, user.name)
    end
  end

  def getUsersAsMapCreatedByManager(conn) do
    id = get_session(conn, :user_id)
    users = TaskTracker.Users.get_users_created_by_manager_id(id)
    users = [TaskTracker.Users.get_user!(id) | users]
    getUserListAsMap(users)
  end


  def create(conn, %{"task" => task_params}) do
    id = get_session(conn, :user_id)
    assigned_to_val = Enum.at(Map.get(task_params, "assigned_to"), 0)
    task_params = Map.put(task_params, "assigned_to", assigned_to_val)
    if id == -1 do
      task_params = Map.put(task_params, "user_id", id)
    end
    usersAsDropdown = getUsersCreatedByManager(conn)
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, availableUsers: usersAsDropdown)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    users = getUsersAsMapCreatedByManager(conn)
    render(conn, "show.html", task: task, users: users)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    users = getUsersCreatedByManager(conn)
    render(conn, "edit.html", task: task, changeset: changeset, availableUsers: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    users = getUsersCreatedByManager(conn)
    assigned_to_val = Enum.at(Map.get(task_params, "assigned_to"), 0)
    task_params = Map.put(task_params, "assigned_to", assigned_to_val)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task, users))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, availableUsers: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
