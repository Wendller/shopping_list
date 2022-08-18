defmodule ShoppingList.Items do
  alias ShoppingList.Items.Item

  @spec validate_all(list(Item.t())) :: atom() | tuple()
  def validate_all(items) do
    is_any_item_invalid? =
      Enum.any?(items, fn item -> item.amount <= 0 or item.unity_price <= 0 end)

    case is_any_item_invalid? do
      true -> {:error, message: "Amount and price of item can't be negative"}
      false -> :ok
    end
  end
end
