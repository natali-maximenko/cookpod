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
    plug BasicAuth, username: "user", password: "secret"
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
    put "/reciples/:id/publish", RecipleController, :publish
  end

  # Other scopes may use custom stacks.
  scope "/api", CookpodWeb.Api, as: :api do
    pipe_through :api

    resources "/reciples", RecipleController, only: [:index, :show]
  end

  scope "/api/swagger" do
    forward("/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :cookpod, swagger_file: "swagger.json")
  end

  def swagger_info do
    %{
      info: %{
        version: "0.1.0",
        title: "Cookpod"
      }
    }
  end

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
