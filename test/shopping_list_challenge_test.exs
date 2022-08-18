defmodule ShoppingListChallengeTest do
  use ExUnit.Case

  alias ShoppingList.Items.Item

  describe "generate_bill_by_emails/2" do
    setup do
      items = [
        %Item{name: "Item1", amount: 3, unity_price: 1400},
        %Item{name: "Item2", amount: 1, unity_price: 5650},
        %Item{name: "Item3", amount: 7, unity_price: 250}
      ]

      emails = ["johndoe@mail.com", "jimhalpert@mail.com", "diwght@mail.com"]

      {:ok, items: items, emails: emails}
    end

    test "return error for invalid emails", %{items: items, emails: emails} do
      invalid_emails = ["invalidemail"] ++ emails

      assert ShoppingListChallenge.generate_bill_by_emails(items, invalid_emails) ==
               {:error, [message: "Invalid e-mail format"]}
    end

    test "return error for duplicated emails", %{items: items, emails: emails} do
      duplicated_emails = ["johndoe@mail.com"] ++ emails

      assert ShoppingListChallenge.generate_bill_by_emails(items, duplicated_emails) ==
               {:error, message: "Duplicated emails"}
    end

    test "return error if emails list is empty", %{items: items} do
      assert ShoppingListChallenge.generate_bill_by_emails(items, []) ==
               {:error, message: "Emails list is empty"}
    end

    test "returns the bill split evenly" do
      items = [
        %Item{name: "Item1", amount: 1, unity_price: 50},
        %Item{name: "Item2", amount: 1, unity_price: 35},
        %Item{name: "Item3", amount: 1, unity_price: 17}
      ]

      emails = [
        "michaelscott@mail.com",
        "jimhalpert@mail.com",
        "diwght@mail.com",
        "toby@mail.com"
      ]

      expected_response = %{
        "michaelscott@mail.com" => 26,
        "jimhalpert@mail.com" => 26,
        "diwght@mail.com" => 25,
        "toby@mail.com" => 25
      }

      assert ShoppingListChallenge.generate_bill_by_emails(items, emails) == expected_response
    end

    test "returns the bill without missing any cent" do
      items = [
        %Item{name: "Item1", amount: 1, unity_price: 50},
        %Item{name: "Item2", amount: 2, unity_price: 25}
      ]

      emails = [
        "michaelscott@mail.com",
        "jimhalpert@mail.com",
        "diwght@mail.com"
      ]

      expected_response = %{
        "michaelscott@mail.com" => 34,
        "jimhalpert@mail.com" => 33,
        "diwght@mail.com" => 33
      }

      assert ShoppingListChallenge.generate_bill_by_emails(items, emails) == expected_response
    end

    test "returns the bill when the price is only one unity" do
      items = [
        %Item{name: "Item1", amount: 1, unity_price: 1}
      ]

      emails = [
        "michaelscott@mail.com",
        "jimhalpert@mail.com",
        "diwght@mail.com"
      ]

      expected_response = %{
        "michaelscott@mail.com" => 1,
        "jimhalpert@mail.com" => 0,
        "diwght@mail.com" => 0
      }

      assert ShoppingListChallenge.generate_bill_by_emails(items, emails) == expected_response
    end

    test "returns the bill when there is no value remaining" do
      items = [
        %Item{name: "Item1", amount: 1, unity_price: 100}
      ]

      emails = [
        "michaelscott@mail.com",
        "jimhalpert@mail.com",
        "diwght@mail.com",
        "pambeasley@mail.com"
      ]

      expected_response = %{
        "michaelscott@mail.com" => 25,
        "jimhalpert@mail.com" => 25,
        "diwght@mail.com" => 25,
        "pambeasley@mail.com" => 25
      }

      assert ShoppingListChallenge.generate_bill_by_emails(items, emails) == expected_response
    end
  end
end
