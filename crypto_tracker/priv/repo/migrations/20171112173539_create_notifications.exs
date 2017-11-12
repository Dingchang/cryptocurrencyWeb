defmodule CryptoTracker.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :currency, :string
      add :threshold, :decimal
      add :above, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:notifications, [:user_id])
  end
end
