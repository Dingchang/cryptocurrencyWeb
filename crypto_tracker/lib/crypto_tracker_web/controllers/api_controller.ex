defmodule CryptoTrackerWeb.APIController do
  use CryptoTrackerWeb, :controller

  def get_prices(conn, %{"currency" => currency}) do
    json conn, Enum.reverse(get_last_30_days(currency))
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
    {float_val, _} = Float.parse(price)
    get_last_30_days_helper(n+1, currency, sofar ++ [%{date: date, price: float_val}])
  end

  def get_last_30_days(currency) do
    get_last_30_days_helper(0, currency, [])
  end
end
