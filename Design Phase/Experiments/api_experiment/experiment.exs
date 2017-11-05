defmodule CoinbaseAPI do

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

  def last_7_loop(n, _) when n == 7 do 

  end

  def last_7_loop(n, currency) do 
    today = Date.utc_today()
    date = Date.to_string(Date.add(today, n * -1))
    price = get_historical_price(currency, date);

    IO.puts "#{currency} price (#{date}): #{price}"

    last_7_loop(n+1, currency)
  end

  def main() do
    IO.puts "\n\nCalculating current cryptocurrency prices using the Coinbase API... \n\n"

    btc_price = get_curr_price("BTC")
    IO.puts "Current BTC Price: #{btc_price}"

    eth_price = get_curr_price("ETH")
    IO.puts "Current ETH Price: #{eth_price}"

    ltc_price = get_curr_price("LTC")
    IO.puts "Current LTC Price: #{ltc_price}"

    IO.puts "\n\nCalculating the historical price of BTC over the past 7 days using the Coinbase API... \n\n"
    last_7_loop(0, "BTC")

    IO.puts "\n\nCalculating the historical price of ETH over the past 7 days using the Coinbase API... \n\n"
    last_7_loop(0, "ETH")

    IO.puts "\n\nCalculating the historical price of LTC over the past 7 days using the Coinbase API... \n\n"
    last_7_loop(0, "LTC")
  end
end

CoinbaseAPI.main()

