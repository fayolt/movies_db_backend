defmodule MoviesDbBackend.MovieController do
  use MoviesDbBackend.Web, :controller

  alias MoviesDbBackend.Movie

  def index(conn, _params) do
    movies = Repo.all(Movie)
    render(conn, "index.json", movies: movies)
  end

  def create(conn, %{"movie" => movie_params}) do
    changeset = Movie.changeset(%Movie{}, movie_params)

    case Repo.insert(changeset) do
      {:ok, movie} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", movie_path(conn, :show, movie))
        |> render("show.json", movie: movie)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MoviesDbBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"objectID" => objectID}) do
    movie = Repo.get!(Movie, objectID)
    render(conn, "show.json", movie: movie)
  end

  def update(conn, %{"objectID" => objectID, "movie" => movie_params}) do
    movie = Repo.get!(Movie, objectID)
    changeset = Movie.changeset(movie, movie_params)

    case Repo.update(changeset) do
      {:ok, movie} ->
        render(conn, "show.json", movie: movie)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MoviesDbBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"objectID" => objectID}) do
    movie = Repo.get!(Movie, objectID)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(movie)

    send_resp(conn, :no_content, "")
  end
end
