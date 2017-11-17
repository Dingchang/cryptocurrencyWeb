defmodule CryptoTracker.Mailer do

  @from "noreply@sandboxf1824ecaeede4b19b949ed15fce5f789.mailgun.org"

  use Mailgun.Client,
      domain: Application.get_env(:crypto_tracker, :mailgun_domain),
      key: Application.get_env(:crypto_tracker, :mailgun_key)

  def send_alert_email(email, msg) do
    send_email to: email,
               from: @from,
               subject: "CryptoCurrency Price Notification Triggered!",
               html: msg
  end

end
