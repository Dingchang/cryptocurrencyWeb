defmodule CryptoTrackerWeb.SessionController do
  use CryptoTrackerWeb, :controller

  alias CryptoTracker.Accounts

  def get_and_auth_user(email, password) do
    user = Accounts.get_user_by_email!(email)
    case Comeonin.Argon2.check_pass(user, password) do
      {:ok, user} -> user
      _else       -> nil
    end
  end

  def login(conn, user_obj) do
    user = get_and_auth_user(user_obj["email"], user_obj["password"])

    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.email}")
      |> redirect(to: currency_path(conn, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "Bad email/password")
      |> redirect(to: currency_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: currency_path(conn, :index))
  end
end
