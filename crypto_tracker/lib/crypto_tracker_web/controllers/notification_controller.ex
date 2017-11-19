defmodule CryptoTrackerWeb.NotificationController do
  use CryptoTrackerWeb, :controller

  alias CryptoTracker.Track
  alias CryptoTracker.Track.Notification

  def index(conn, _params) do
    notifications = Track.list_notifications()
    render(conn, "index.html", notifications: notifications)
  end

  def new(conn, _params) do
    changeset = Track.change_notification(%Notification{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"notification" => notification_params}) do
    curr_user = conn.assigns[:current_user]
    if curr_user do
        notification_params = Map.put(notification_params, "user_id", curr_user.id)
    end
    case Track.create_notification(notification_params) do
      {:ok, notification} ->
        conn
        |> put_flash(:info, "Notification created successfully.")
        |> redirect(to: currency_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    notification = Track.get_notification!(id)
    render(conn, "show.html", notification: notification)
  end

  def edit(conn, %{"id" => id}) do
    notification = Track.get_notification!(id)
    changeset = Track.change_notification(notification)
    render(conn, "edit.html", notification: notification, changeset: changeset)
  end

  def update(conn, %{"id" => id, "notification" => notification_params}) do
    notification = Track.get_notification!(id)

    case Track.update_notification(notification, notification_params) do
      {:ok, notification} ->
        conn
        |> put_flash(:info, "Notification updated successfully.")
        |> redirect(to: notification_path(conn, :show, notification))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", notification: notification, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    notification = Track.get_notification!(id)
    {:ok, _notification} = Track.delete_notification(notification)

    conn
    |> put_flash(:info, "Notification deleted successfully.")
    |> redirect(to: NavigationHistory.last_path(conn, default: currency_path(conn, :index)))
  end
end
