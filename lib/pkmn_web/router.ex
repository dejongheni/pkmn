defmodule PkmnWeb.Router do
  use PkmnWeb, :router

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

  scope "/", PkmnWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/pokemon/:id", PkmnController, :show_pkmn
    get "/pokemon", PkmnController, :list_pkmn
  end

  # Other scopes may use custom stacks.
  # scope "/api", PkmnWeb do
  #   pipe_through :api
  # end
end
