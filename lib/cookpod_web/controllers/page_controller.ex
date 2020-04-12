defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  action_fallback CookpodWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def terms(conn, _params) do
    render(conn, "terms.html")
  end
end
