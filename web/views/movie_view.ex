defmodule MoviesDbBackend.MovieView do
  use MoviesDbBackend.Web, :view

  def render("index.json", %{movies: movies}) do
    %{data: render_many(movies, MoviesDbBackend.MovieView, "movie.json")}
  end

  def render("show.json", %{movie: movie}) do
    %{data: render_one(movie, MoviesDbBackend.MovieView, "movie.json")}
  end

  def render("movie.json", %{movie: movie}) do
    %{title: movie.title,
      alternative_titles: movie.alternative_titles,
      year: movie.year,
      image: movie.image,
      color: movie.color,
      score: movie.score,
      rating: movie.rating,
      actors: movie.actors,
      actor_facets: movie.actor_facets,
      genre: movie.genre,
      objectID: movie.objectID}
  end
end
