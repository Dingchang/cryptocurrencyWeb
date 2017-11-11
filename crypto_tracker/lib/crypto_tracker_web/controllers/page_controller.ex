defmodule CryptoTrackerWeb.PageController do
  use CryptoTrackerWeb, :controller

  def index(conn, _params) do
	redirect conn, to: currency_path(conn, :index)
  end
end
