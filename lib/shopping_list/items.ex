defmodule ShoppingList.Items do
  alias ShoppingList.Items.Item

  @spec validate_all(list(Item.t())) :: atom() | tuple()
  def validate_all([%Item{} = _item | _] = items) do
    is_any_invalid_item? =
      Enum.any?(items, fn item ->
        is_any_non_positive_value = item.amount <= 0 or item.unity_price <= 0

        is_any_non_integer_value = not is_integer(item.amount) or not is_integer(item.unity_price)

        is_any_non_positive_value or is_any_non_integer_value
      end)

    case is_any_invalid_item? do
      true -> {:error, message: "Amount and price must be positive integers"}
      false -> :ok
    end
  end

  def validate_all([]), do: {:error, message: "Items list is empty"}

  @spec calculate_total_price(list(Item.t())) :: {:ok, integer()}
  def calculate_total_price(items) do
    items_total_price =
      Enum.reduce(items, 0, fn item, total_price ->
        price_per_item = item.unity_price * item.amount

        total_price + price_per_item
      end)

    {:ok, items_total_price}
  end
end
