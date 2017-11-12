defmodule CryptoTracker.TrackTest do
  use CryptoTracker.DataCase

  alias CryptoTracker.Track

  describe "currencies" do
    alias CryptoTracker.Track.Currency

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def currency_fixture(attrs \\ %{}) do
      {:ok, currency} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_currency()

      currency
    end

    test "list_currencies/0 returns all currencies" do
      currency = currency_fixture()
      assert Track.list_currencies() == [currency]
    end

    test "get_currency!/1 returns the currency with given id" do
      currency = currency_fixture()
      assert Track.get_currency!(currency.id) == currency
    end

    test "create_currency/1 with valid data creates a currency" do
      assert {:ok, %Currency{} = currency} = Track.create_currency(@valid_attrs)
      assert currency.name == "some name"
    end

    test "create_currency/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_currency(@invalid_attrs)
    end

    test "update_currency/2 with valid data updates the currency" do
      currency = currency_fixture()
      assert {:ok, currency} = Track.update_currency(currency, @update_attrs)
      assert %Currency{} = currency
      assert currency.name == "some updated name"
    end

    test "update_currency/2 with invalid data returns error changeset" do
      currency = currency_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_currency(currency, @invalid_attrs)
      assert currency == Track.get_currency!(currency.id)
    end

    test "delete_currency/1 deletes the currency" do
      currency = currency_fixture()
      assert {:ok, %Currency{}} = Track.delete_currency(currency)
      assert_raise Ecto.NoResultsError, fn -> Track.get_currency!(currency.id) end
    end

    test "change_currency/1 returns a currency changeset" do
      currency = currency_fixture()
      assert %Ecto.Changeset{} = Track.change_currency(currency)
    end
  end

  describe "prices" do
    alias CryptoTracker.Track.Price

    @valid_attrs %{date: "some date", price: "120.5"}
    @update_attrs %{date: "some updated date", price: "456.7"}
    @invalid_attrs %{date: nil, price: nil}

    def price_fixture(attrs \\ %{}) do
      {:ok, price} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_price()

      price
    end

    test "list_prices/0 returns all prices" do
      price = price_fixture()
      assert Track.list_prices() == [price]
    end

    test "get_price!/1 returns the price with given id" do
      price = price_fixture()
      assert Track.get_price!(price.id) == price
    end

    test "create_price/1 with valid data creates a price" do
      assert {:ok, %Price{} = price} = Track.create_price(@valid_attrs)
      assert price.date == "some date"
      assert price.price == Decimal.new("120.5")
    end

    test "create_price/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_price(@invalid_attrs)
    end

    test "update_price/2 with valid data updates the price" do
      price = price_fixture()
      assert {:ok, price} = Track.update_price(price, @update_attrs)
      assert %Price{} = price
      assert price.date == "some updated date"
      assert price.price == Decimal.new("456.7")
    end

    test "update_price/2 with invalid data returns error changeset" do
      price = price_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_price(price, @invalid_attrs)
      assert price == Track.get_price!(price.id)
    end

    test "delete_price/1 deletes the price" do
      price = price_fixture()
      assert {:ok, %Price{}} = Track.delete_price(price)
      assert_raise Ecto.NoResultsError, fn -> Track.get_price!(price.id) end
    end

    test "change_price/1 returns a price changeset" do
      price = price_fixture()
      assert %Ecto.Changeset{} = Track.change_price(price)
    end
  end

  describe "notifications" do
    alias CryptoTracker.Track.Notification

    @valid_attrs %{above: true, currency: "some currency", threshold: "120.5"}
    @update_attrs %{above: false, currency: "some updated currency", threshold: "456.7"}
    @invalid_attrs %{above: nil, currency: nil, threshold: nil}

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_notification()

      notification
    end

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Track.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Track.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Track.create_notification(@valid_attrs)
      assert notification.above == true
      assert notification.currency == "some currency"
      assert notification.threshold == Decimal.new("120.5")
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      assert {:ok, notification} = Track.update_notification(notification, @update_attrs)
      assert %Notification{} = notification
      assert notification.above == false
      assert notification.currency == "some updated currency"
      assert notification.threshold == Decimal.new("456.7")
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_notification(notification, @invalid_attrs)
      assert notification == Track.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Track.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Track.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Track.change_notification(notification)
    end
  end
end
