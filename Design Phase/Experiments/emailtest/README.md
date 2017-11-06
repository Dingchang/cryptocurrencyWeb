# Emailtest

To start, make sure the recipient is in the authorized recipients list in your
Mailgun account.

To send an email, run the following command:
```
$ iex -S mix phoenix.server
. . .
iex> Emailtest.Mailer.send_alert_email("us@example.com")
{:ok, "OK"}
```

## Reference
  - [Sending Email with Mailgun](https://hexdocs.pm/phoenix/1.3.0-rc.0/sending_email_with_mailgun.html)
