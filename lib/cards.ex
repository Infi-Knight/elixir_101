defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a list of playing cards
  """
  # In elixir there is an implicit return
  # i.e result of last line is automatically returned
  # you can use single quotes
  def create_deck do 
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven",
             "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Clubs", "Diamonds", "Hearts", "Spades"]

    # list comprehension
    # it is a mapping where the return value of do block
    # is mapped to the item being iterated over.
    # in this case we are mapping the list of cards to each suit
    # the overall comprehension returns a list
    # '#{}' are the template strings
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffles a deck of cards
  """
  def shuffle(deck) do
    # Immutability 
    Enum.shuffle(deck)
  end

  @doc """
    Retruns true if a card is in the deck, false otherwise

  ## Examples

      iex> deck = Cards.create_deck
      iex(2)> Cards.contains?(deck, "Ace of Spades")
      true

  """
  # Convention: a method with a question mark
  # returns a boolean value
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a deck and the remainder of a deck
    The `hand_size` argument indicates how many cards
    should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Clubs"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves a `deck` to the file, `filename`
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a file from the filesystem
  """
  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term(binary)
      # tell elixir that we don't care about reason 
      { :error, _reason} -> "#{filename} does not exist"
    end
  end

  @doc """
    Creates a deck, shuffles it, and returns a deal.
    `hand_size` indicates the size of the hand to be returned
  """
  def create_hand(hand_size) do
    # elixir's pipe operator will automatically pass the result from
    # first function to input of the second
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
