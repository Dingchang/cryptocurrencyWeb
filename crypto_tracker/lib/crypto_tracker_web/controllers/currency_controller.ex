defmodule CryptoTrackerWeb.CurrencyController do
  use CryptoTrackerWeb, :controller

  alias CryptoTracker.Track
  alias CryptoTracker.Track.Currency

  def index(conn, _params) do
    currencies = Track.list_currencies()

    render(conn, "index.html", currencies: currencies)
  end

  def get_curr_price(currency) do
    resp = HTTPoison.get!("https://api.coinbase.com/v2/prices/#{currency}-USD/spot")
    data = Poison.decode!(resp.body)
    data["data"]["amount"]
  end

  def get_historical_price(currency, date) do
    resp = HTTPoison.get!("https://api.coinbase.com/v2/prices/#{currency}-USD/spot?date=#{date}")
    data = Poison.decode!(resp.body)
    data["data"]["amount"]
  end

  def get_last_30_days_helper(n, _, sofar) when n == 30 do 
    sofar
  end

  def get_last_30_days_helper(n, currency, sofar) do 
    today = Date.utc_today()
    date = Date.to_string(Date.add(today, n * -1))
    price = get_historical_price(currency, date);

    get_last_30_days_helper(n+1, currency, sofar ++ [price])
  end

  def get_last_30_days(currency) do
    get_last_30_days_helper(0, currency, [])
  end

  def new(conn, _params) do
    changeset = Track.change_currency(%Currency{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"currency" => currency_params}) do
    case Track.create_currency(currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency created successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    currency = Track.get_currency!(id)
    render(conn, "show.html", currency: currency)
  end

  def edit(conn, %{"id" => id}) do
    currency = Track.get_currency!(id)
    changeset = Track.change_currency(currency)
    render(conn, "edit.html", currency: currency, changeset: changeset)
  end

  def update(conn, %{"id" => id, "currency" => currency_params}) do
    currency = Track.get_currency!(id)

    case Track.update_currency(currency, currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency updated successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", currency: currency, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    currency = Track.get_currency!(id)
    {:ok, _currency} = Track.delete_currency(currency)

    conn
    |> put_flash(:info, "Currency deleted successfully.")
    |> redirect(to: currency_path(conn, :index))
  end
end
