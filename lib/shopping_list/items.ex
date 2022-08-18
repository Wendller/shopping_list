defmodule ShoppingList.Items do
  alias ShoppingList.Items.Item

  @spec validate_all(list(Item.t())) :: atom() | tuple()
  def validate_all([%Item{} = _item | _] = items) do
    is_any_item_invalid? =
      Enum.any?(items, fn item -> item.amount <= 0 or item.unity_price <= 0 end)

    case is_any_item_invalid? do
      true -> {:error, message: "Amount and price of item can't be negative"}
      false -> :ok
    end
  end

  def validate_all([]), do: {:error, message: "Items list is empty"}
end
