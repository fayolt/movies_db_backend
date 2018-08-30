defmodule MoviesDbBackend.MovieController do
  use MoviesDbBackend.Web, :controller

  alias MoviesDbBackend.Movie

  def sync(conn, _params) do
    movies = Repo.all(Movie)
    movies
      |> Enum.map(fn movie -> %{title: movie.title, alternative_titles: movie.alternative_titles,
      year: movie.year, image: movie.image, color: movie.color, score: movie.score, rating: movie.rating, 
      actors: movie.actors, actor_facets: movie.actor_facets, genre: movie.genre, objectID: movie.objectID} end)
      |> Stream.chunk_every(1000, 1000, [])
      |> Enum.to_list
      |> Enum.each(fn mv -> Algolia.save_objects("movies_db_index", mv) end)
      # |> Enum.each(fn lst -> IO.inspect length(lst) end)
    conn
      |> put_status(200)
      |> json(movies |> Enum.map(fn movie -> movie.objectID end))
  end
  
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
