defmodule MoviesDbBackend.Router do
  use MoviesDbBackend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MoviesDbBackend do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", MoviesDbBackend do
    pipe_through :api
    get "/movies/index", MovieController, :sync
    resources "/movies", MovieController
  end
end
