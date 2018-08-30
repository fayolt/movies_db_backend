defmodule MoviesDbBackend.Movie do
  use MoviesDbBackend.Web, :model
  
  @primary_key {:objectID, :string, []}
  @derive {Phoenix.Param, key: :objectID}
  schema "movies" do
    field :title, :string
    field :alternative_titles, {:array, :string}
    field :year, :integer
    field :image, :string
    field :color, :string
    field :score, :float
    field :rating, :integer
    field :actors, {:array, :string}
    field :actor_facets, {:array, :string}
    field :genre, {:array, :string}

    timestamps()
  end
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :alternative_titles, :year, :image, :color, :score, :rating, :actors, :actor_facets, :genre, :objectID])
    |> validate_required([:title, :alternative_titles, :year, :image, :color, :score, :rating, :actors, :actor_facets, :genre, :objectID])
  end
end
