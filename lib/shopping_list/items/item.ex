defmodule ShoppingList.Items.Item do
  @type t :: %ShoppingList.Items.Item{
          name: String.t(),
          amount: integer(),
          unity_price: integer()
        }

  defstruct [:name, :amount, :unity_price]
end
