defmodule ShoppingListChallengeTest do
  use ExUnit.Case
  doctest ShoppingListChallenge

  test "greets the world" do
    assert ShoppingListChallenge.hello() == :world
  end
end
