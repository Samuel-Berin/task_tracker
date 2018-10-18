# Taken from Nat's Notes 11
defmodule TaskTrackerWeb.Plugs.FetchSession do
  import Plug.Conn


  def init(args) do
    args
  end

  def call(conn, _args) do
    user = TaskTracker.Users.get_user_from_id(get_session(conn, :user_id) || -1)

    if user do
      assign(conn, :current_user, user)
    else 
      assign(conn, :current_user, nil)
    end
  end
end
