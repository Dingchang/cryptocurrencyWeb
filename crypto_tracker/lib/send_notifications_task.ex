defmodule CryptoTracker.SendNotificationsTask do

  def run do
    IO.puts("Running send notificatons task")
    notifs = CryptoTracker.Track.list_notifications()
    process_notifs(notifs)
  end

  def process_notifs(notifs) do
    if length(notifs) != 0 do
      [notif | more] = CryptoTracker.Track.list_notifications()

      currency = notif.currency
      curr_price = get_curr_price(currency)
      threshold = Decimal.to_string(notif.threshold);
      user_id = notif.user_id;
      above_threshold = Decimal.to_integer(Decimal.compare(Decimal.new(curr_price), notif.threshold)) == 1


      cond do
        (notif.above and above_threshold) ->
          IO.puts("Here, we should be sending an email to user_id #{user_id} because #{currency}'s price: #{curr_price} has gone above #{threshold}")
          CryptoTracker.Track.delete_notification(notif)

        (not notif.above and not above_threshold) ->
          IO.puts("Here, we should be sending an email to user_id #{user_id} because #{currency}'s price: #{curr_price} has gone below #{threshold}")
          CryptoTracker.Track.delete_notification(notif)
      end

      process_notifs(more)
    end
  end

  def get_curr_price(currency) do
    resp = HTTPoison.get!("https://api.coinbase.com/v2/prices/#{currency}-USD/spot")
    data = Poison.decode!(resp.body)
    data["data"]["amount"]
  end
end
