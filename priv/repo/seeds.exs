# alias MoviesDbBackend.{Repo, Movie}

# %{"movies" => movies} = File.read!("movies.json") |> Poison.decode!

# new_movies = movies |> Enum.map(fn movie_data -> Movie.changeset(%Movie{}, movie_data) end)
# new_movies |> Enum.each(fn changeset -> Repo.insert!(changeset) end)

# Algolia.set_settings("movies_db_index",
#     %{
#         "hitsPerPage" => 21,
#         "searchableAttributes" => [
#             "title",
#             "alternative_titles",
#             "actors",
#             "genre",
#             "year",
#             "rating"
#         ]
#     }
# )

# Algolia.add_objects("movies_db_index", movies)
