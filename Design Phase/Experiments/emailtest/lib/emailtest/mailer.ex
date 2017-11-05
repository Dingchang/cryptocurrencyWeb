defmodule Emailtest.Mailer do

  @from "noreply@sandboxf1824ecaeede4b19b949ed15fce5f789.mailgun.org"

  use Mailgun.Client,
      domain: Application.get_env(:emailtest, :mailgun_domain),
      key: Application.get_env(:emailtest, :mailgun_key)

  def send_alert_email(email) do
    send_email to: email,
               from: @from,
               subject: "Alert",
               html: "<h3>Test Alert</h3>"
  end

end
