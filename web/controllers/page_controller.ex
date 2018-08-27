defmodule MoviesDbBackend.PageController do
  use MoviesDbBackend.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
