defmodule MoviesDbBackend.MovieController do
  use MoviesDbBackend.Web, :controller

  alias MoviesDbBackend.Movie

  def create(conn,  %{"movie" => movie_params}) do
    movie_params = Map.put(movie_params, "objectID", UUID.uuid4(:hex))
    changeset = Movie.changeset(%Movie{}, movie_params)
    case Repo.insert(changeset) do
      {:ok, movie} ->
        Algolia.add_object("movies_db_index", movie_params)
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
  
  def delete(conn, %{"id" => objectID}) do
    movie = Repo.get!(Movie, objectID)
    case Repo.delete(movie) do
      {:ok, _} -> 
        Algolia.delete_object("movies_db_index", objectID)
        send_resp(conn, :no_content, "")
      {:error, changeset} -> 
        conn
        |> put_status(:unprocessable_entity)
        |> render(MoviesDbBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def index(conn, _params) do
    movies = Repo.all(Movie)
    render(conn, "index.json", movies: movies)
  end

  def sync(conn, _params) do
    movies = Repo.all(Movie)
    movies
      |> Enum.map(fn movie -> %{title: movie.title, alternative_titles: movie.alternative_titles,
      year: movie.year, image: movie.image, color: movie.color, score: movie.score, rating: movie.rating, 
      actors: movie.actors, actor_facets: movie.actor_facets, genre: movie.genre, objectID: movie.objectID} end)
      |> Stream.chunk_every(1000, 1000, [])
      |> Enum.to_list
      |> Enum.each(fn mv -> Algolia.save_objects("movies_db_index", mv) end)
    send_resp(conn, :no_content, "")
  end

  def show(conn, %{"id" => objectID}) do
    movie = Repo.get!(Movie, objectID)
    render(conn, "show.json", movie: movie)
  end

  def update(conn, %{"id" => objectID, "movie" => movie_params}) do
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

end
