# frozen_string_literal: true

class Deck
  attr_reader :cards

  SUITS = ['+', '<3', '^', '<>'].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  def initialize
    @cards = []
    generate_deck
  end

  def take_card
    generate_deck if cards.empty?
    cards.pop
  end

  private

  attr_writer :cards

  def generate_deck
    SUITS.each do |suit|
      VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle!
  end
end
