defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates a deck of 52" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    # assert deck != Cards.shuffle(deck)
    # above line is equivalent to this refute line
    refute deck == Cards.shuffle(deck)
  end
end
