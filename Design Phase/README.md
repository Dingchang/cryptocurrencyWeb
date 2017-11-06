# Cryptocurrency Monitoring Project Design
## Overview
Cryptocurrency monitoring website is a web-app dedicated to monitoring the prices of mainstream cryptocurrencies such as Bitcoin and Ethereum. It obtains the real-time prices of each cryptocurrency via Coinbase API and displays a line chart which shows the price in last 30 days. Users can add or remove chart on their page if logged in. They can also sign up an email notification if the price has passed over or below a given threshold.
## User Stories
"As a visitor, I can see the price of different cryptocurrencies in past 30 days" <br>
\- Alex visits the cryptocurrency monitoring website. The website displays a list of price line chart of each cryptocurrency from Coinbase API.

"As a new user, I can create an account"<br>
\- Bella wants to use more feature of the cryptocurrency monitoring website. So she clicks the "Sign in" button at the top right corner and the website pops a form letting her enter her information.

"As a normal user, I can customize the cryptocurrencies in my home page"<br>
\- Carlo is investing Bitcoin and does not care too much about the price of other cryptocurrencies. So she clicked the X mark at the right or each price chart and the price charts disappear on her home page.

"As a normal user, I can sign up notification if the price of a certain cryptocurrency cross a threshold"<br>
\- Deckard wants to get alert if the price of Bitcoin passes $6000. So he goes to the dropdown panel under the Bitcoin price chart, enters the threshold, and clicks ''add notification" button. He will receive an email when the price passes $6000.
## Data Design
### Cryptocurrency
- name

The Cryptocurrency resource only have a name field because it is main used for reference in Track. There is no need to store the prices because they are all stored in API.
### Track
- user id
- cryptocurrency id
- threshold price
- recorded price

The Track resource stores the user id and the cryptocurrency id for the use to send notification email. When a Track is created, it automatically stores the price of selected cryptocurrency at that time for the use of wording in notification email. For example, if the threshold is $3000 and the recored price is $2800, the email will say "the price goes above $3000" .
### User
- email
- password
- tracks

The User resource has the email and password to login. It also stores all the Tracks created by this user.
## App Interface
Most interactions in our app would take place on the main page. By default, the main page displays a list of charts for the prices of all cryptocurrencies. It also has a navigation bar to guide user login. If logged in, the user can add or delete chart on their main page. A dropdown panel will also appear on each chart. It contains not only all the tracks current user have for this cryptocurrency, and also a form to create a new track. For each user, there is also a profile page where the user can edit or delete tracks and other user information.
## Experiments
### Send email via Mailgun
Sending email notification is a key part of our cryptocurrency monitoring website. We manage to send an email by using Mailgun API. Recipients have to pass the verification from Mailgun before they could receive email. As a result, the first time a user signs up a track, the app should notify the user to agree receiving to an email from Mailgun. In addition, we are going to set up our domain instead of using default domain in Mailgun to send emails.
## Project Status
