defmodule MoviesDbBackend.MovieTest do
  use MoviesDbBackend.ModelCase

  alias MoviesDbBackend.Movie

  @valid_attrs %{actor_facets: [], actors: [], alternative_titles: [], color: "some color", genre: [], image: "some image", objectID: "some objectID", rating: 42, score: 120.5, title: "some title", year: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Movie.changeset(%Movie{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Movie.changeset(%Movie{}, @invalid_attrs)
    refute changeset.valid?
  end
end
