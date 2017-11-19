defmodule CryptoTracker.Mailer do


  use Mailgun.Client,
      domain: Application.get_env(:crypto_tracker, :mailgun_domain),
      key: Application.get_env(:crypto_tracker, :mailgun_key)

  def send_alert_email(email, msg) do
    send_email to: email,
               from: "notification-sender@cryptotracker.ssaleem.me",
               subject: "CryptoTracker Price Notification Triggered!",
               html: msg
  end

end
