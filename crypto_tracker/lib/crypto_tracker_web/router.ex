defmodule CryptoTrackerWeb.Router do
  use CryptoTrackerWeb, :router
  import CryptoTrackerWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
    plug NavigationHistory.Tracker
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CryptoTrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    #resources "/", CurrencyController
    resources "/currencies", CurrencyController
    resources "/users", UserController
    resources "/notifications", NotificationController
    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout
  end

  # Other scopes may use custom stacks.
   scope "/api", CryptoTrackerWeb do
     pipe_through :api
     get "/prices", APIController, :get_prices
get "/prices_yearly", APIController, :get_yearly_prices
   end
end
