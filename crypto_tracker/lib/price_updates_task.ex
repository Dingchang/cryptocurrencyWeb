defmodule CryptoTracker.PriceUpdatesTask do
  def run do
    CryptoTrackerWeb.Endpoint.broadcast("prices:btc", "price_update", %{price: get_curr_price("BTC")})
    CryptoTrackerWeb.Endpoint.broadcast("prices:ltc", "price_update", %{price: get_curr_price("LTC")})
    CryptoTrackerWeb.Endpoint.broadcast("prices:eth", "price_update", %{price: get_curr_price("ETH")})
  end

  def get_curr_price(currency) do
    resp = HTTPoison.get!("https://api.coinbase.com/v2/prices/#{currency}-USD/spot")
    data = Poison.decode!(resp.body)
    data["data"]["amount"]
  end
end
