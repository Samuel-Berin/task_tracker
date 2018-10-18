defmodule TaskTrackerWeb.Router do
  use TaskTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TaskTrackerWeb.Plugs.FetchSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TaskTrackerWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/tasks", TaskController
    # Taken from Nat's Notes and github.com/NatTuck/husky_shop/lib/husky_shop_web/router.ex
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskTrackerWeb do
  #   pipe_through :api
  # end
end
