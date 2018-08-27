defmodule MoviesDbBackend.Repo.Migrations.CreateMovie do
  use Ecto.Migration

  def change do
    create table(:movies, primary_key: false) do
      add :title, :string
      add :alternative_titles, {:array, :string}
      add :year, :integer
      add :image, :string
      add :color, :string
      add :score, :float
      add :rating, :integer
      add :actors, {:array, :string}
      add :actor_facets, {:array, :string}
      add :genre, {:array, :string}
      add :objectID, :string, primary_key: true

      timestamps()
    end
  end
end
