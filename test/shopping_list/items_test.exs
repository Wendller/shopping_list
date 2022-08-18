defmodule ShoppingList.ItemsTest do
  use ExUnit.Case

  alias ShoppingList.Items
  alias ShoppingList.Items.Item

  setup do
    items = [
      %Item{name: "Item1", amount: 3, unity_price: 1400},
      %Item{name: "Item2", amount: 1, unity_price: 5650},
      %Item{name: "Item3", amount: 7, unity_price: 250}
    ]

    {:ok, items: items}
  end

  describe "validate_all/1" do
    test "return error if amount of item is negative", %{items: items} do
      invalid_item = %Item{name: "Item4", amount: -3, unity_price: 1100}
      invalid_items_list = items ++ [invalid_item]

      assert Items.validate_all(invalid_items_list) ==
               {:error, message: "Amount and price of item can't be negative"}
    end

    test "return error if unity price of item is negative", %{items: items} do
      invalid_item = %Item{name: "Item4", amount: 1, unity_price: -1600}
      invalid_items_list = items ++ [invalid_item]

      assert Items.validate_all(invalid_items_list) ==
               {:error, message: "Amount and price of item can't be negative"}
    end

    test "return error if items list is empty" do
      assert Items.validate_all([]) == {:error, message: "Items list is empty"}
    end

    test "validate all items", %{items: items} do
      assert Items.validate_all(items) == :ok
    end
  end

  describe "calculate_total_price/1" do
    test "returns the total price of list of items", %{items: items} do
      assert Items.calculate_total_price(items) == {:ok, 11_600}
    end
  end
end
