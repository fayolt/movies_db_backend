defmodule MoviesDbBackend.MovieControllerTest do
  use MoviesDbBackend.ConnCase

  alias MoviesDbBackend.Movie
  @valid_attrs %{actor_facets: [], actors: [], alternative_titles: [], color: "some color", genre: [], image: "some image", rating: 42, score: 120.5, title: "test title", year: 42}
  @invalid_attrs %{year: "Some year"}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, movie_path(conn, :create), movie: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, movie_path(conn, :create), movie: @valid_attrs
    assert json_response(conn, 201)["movie"]["objectID"]
    assert Repo.get_by(Movie, @valid_attrs)
    :timer.sleep(5000)
    {_, resp} = Algolia.search("movies_db_index", "test title", [attributesToRetrieve: "score", hitsPerPage: 1])
    assert resp |> Map.get("hits") |> List.first |> Map.get("score") == 120.5
  end

  test "deletes chosen resource", %{conn: conn} do
    movie = Repo.insert! Map.merge(%Movie{objectID: UUID.uuid4(:hex)}, @valid_attrs)
    conn = delete conn, movie_path(conn, :delete, movie)
    assert response(conn, 204)
    refute Repo.get(Movie, movie.objectID)
    # :timer.sleep(5000)
    # {_, resp} = Algolia.search("movies_db_index", "test title", [attributesToRetrieve: "score", hitsPerPage: 1])
    # assert resp |> Map.get("hits") |> length == 0
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, movie_path(conn, :index)
    assert json_response(conn, 200)["movies"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    movie = Repo.insert! Map.merge(%Movie{objectID: UUID.uuid4(:hex)}, @valid_attrs)
    conn = get conn, movie_path(conn, :show, movie)
    assert json_response(conn, 200)["movie"] == %{"objectID" => movie.objectID,
      "title" => movie.title,
      "alternative_titles" => movie.alternative_titles,
      "year" => movie.year,
      "image" => movie.image,
      "color" => movie.color,
      "score" => movie.score,
      "rating" => movie.rating,
      "actors" => movie.actors,
      "actor_facets" => movie.actor_facets,
      "genre" => movie.genre}
  end

  test "renders page not found when objectID is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, movie_path(conn, :show, -1)
    end
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    movie = Repo.insert! Map.merge(%Movie{objectID: UUID.uuid4(:hex)}, @valid_attrs)
    conn = put conn, movie_path(conn, :update, movie), movie: @valid_attrs
    assert json_response(conn, 200)["movie"]["objectID"]
    assert Repo.get_by(Movie, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    movie = Repo.insert! Map.merge(%Movie{objectID: UUID.uuid4(:hex)}, @valid_attrs)
    conn = put conn, movie_path(conn, :update, movie), movie: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

end
