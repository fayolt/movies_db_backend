alias MoviesDbBackend.{Repo, Movie}

%{"movies" => movies} = File.read!("movies.json") |> Poison.decode!
movies |> Enum.map(fn movie_data -> Movie.changeset(%Movie{}, movie_data) end)
       |> Enum.each(fn changeset -> Repo.insert!(changeset) end)