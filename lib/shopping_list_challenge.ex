defmodule ShoppingListChallenge do
  alias ShoppingList.Items
  alias ShoppingList.Items.Item

  @spec generate_bill_by_emails(list(Item.t()), list(String.t())) :: map()
  def generate_bill_by_emails(items_list, emails) when is_list(emails) and length(emails) > 0 do
    with :ok <- validate_emails_format(emails),
         :ok <- validate_email_duplication(emails),
         :ok <- Items.validate_all(items_list),
         {:ok, total_price} <- Items.calculate_total_price(items_list) do
      emails_amount = length(emails)
      price_per_email = Integer.floor_div(total_price, emails_amount)
      remaining_value = Integer.mod(total_price, emails_amount)
      emails_to_distribute_ramaining_value = Enum.take(emails, remaining_value)

      bill_of_equal_price_per_email = Enum.into(emails, %{}, &{&1, price_per_email})

      bill_of_remaining_value =
        Enum.into(emails_to_distribute_ramaining_value, %{}, &{&1, price_per_email + 1})

      Map.merge(bill_of_equal_price_per_email, bill_of_remaining_value)
    end
  end

  def generate_bill_by_emails(_items_list, []), do: {:error, message: "Emails list is empty"}

  defp validate_emails_format(emails) do
    are_all_email_valid? = Enum.all?(emails, fn email -> Regex.match?(~r/@/, email) end)

    case are_all_email_valid? do
      false -> {:error, message: "Invalid e-mail format"}
      true -> :ok
    end
  end

  defp validate_email_duplication([_first_email | _] = emails) do
    unique_emails = Enum.uniq(emails)

    case length(emails) > length(unique_emails) do
      true -> {:error, message: "Duplicated emails"}
      false -> :ok
    end
  end
end
