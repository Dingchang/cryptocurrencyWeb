defmodule CryptoTracker.Track.Currency do
  use Ecto.Schema
  import Ecto.Changeset
  alias CryptoTracker.Track.Currency


  schema "currencies" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Currency{} = currency, attrs) do
    currency
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
