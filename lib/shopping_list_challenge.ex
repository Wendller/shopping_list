defmodule ShoppingListChallenge do
  @spec generate_bill_by_email(list(map()), list(String.t())) :: map()
  def generate_bill_by_email(_items_list, emails) do
    with :ok <- validate_emails_format(emails),
         :ok <- validate_email_duplication(emails) do
      emails
    end
  end

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
