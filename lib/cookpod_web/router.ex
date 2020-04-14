defmodule CookpodWeb.Router do
  use CookpodWeb, :router
  use Plug.ErrorHandler

  alias CookpodWeb.Plugs.Auth
  alias CookpodWeb.Plugs.BasicAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BasicAuth, username: "user", password: "secret"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Auth
  end

  scope "/", CookpodWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController
  end

  # Definitely logged in scope
  scope "/", CookpodWeb do
    pipe_through [:browser, :auth]

    get "/terms", PageController, :terms
    resources "/reciples", RecipleController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookpodWeb do
  #   pipe_through :api
  # end

  def handle_errors(conn, %{kind: :error, reason: %Phoenix.Router.NoRouteError{}}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_layout({CookpodWeb.LayoutView, :app})
    |> put_view(CookpodWeb.ErrorView)
    |> render("404.html")
  end

  def handle_errors(conn, %{kind: :error, reason: %Phoenix.ActionClauseError{}}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_layout({CookpodWeb.LayoutView, :app})
    |> put_view(CookpodWeb.ErrorView)
    |> render("400.html")
  end

  def handle_errors(conn, _) do
    conn
  end
end
