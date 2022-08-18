defmodule ShoppingListChallengeTest do
  use ExUnit.Case

  describe "generate_bill_by_email/2" do
    setup do
      items = [
        %{name: "Item1", amount: 3, unity_price: 1400},
        %{name: "Item2", amount: 1, unity_price: 5650},
        %{name: "Item3", amount: 7, unity_price: 250}
      ]

      emails = ["johndoe@mail.com", "jimhalpert@mail.com", "diwght@mail.com"]

      {:ok, items: items, emails: emails}
    end

    test "return error for invalid emails", %{items: items, emails: emails} do
      invalid_emails = ["invalidemail"] ++ emails

      assert ShoppingListChallenge.generate_bill_by_email(items, invalid_emails) ==
               {:error, [message: "Invalid e-mail format"]}
    end
  end
end
