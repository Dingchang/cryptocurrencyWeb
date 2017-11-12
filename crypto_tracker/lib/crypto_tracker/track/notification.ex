defmodule CryptoTracker.Track.Notification do
  use Ecto.Schema
  import Ecto.Changeset
  alias CryptoTracker.Track.Notification


  schema "notifications" do
    field :above, :boolean, default: false
    field :currency, :string
    field :threshold, :decimal
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Notification{} = notification, attrs) do
    notification
    |> cast(attrs, [:currency, :threshold, :above, :user_id])
    |> validate_required([:currency, :threshold, :above, :user_id])
  end
end
