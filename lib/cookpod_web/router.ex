defmodule CookpodWeb.Router do
  use CookpodWeb, :router

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

  pipeline :auth do
    plug CookpodWeb.AuthPlug
  end

  scope "/", CookpodWeb do
    pipe_through :browser

    resources "/sessions", SessionController
  end

   # Definitely logged in scope
   scope "/", CookpodWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
    get "/terms", PageController, :terms
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookpodWeb do
  #   pipe_through :api
  # end
end
