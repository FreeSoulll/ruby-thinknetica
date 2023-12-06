# frozen_string_literal: true

class Player
  attr_reader :name
  attr_accessor :cards, :money

  def initialize
    @money = 100
    @cards = []
  end

  def points
    return 0 unless cards.length.positive?

    points = 0
    cards.each do |card|
      if card.value == 'A'
        points += (points >= 11 ? 1 : 11)
      else
        points += (card.value.to_i.zero? ? 10 : card.value)
      end
    end

    points
  end

  def bet
    return puts 'you dont have enough money' if money.zero?

    self.money -= 10
  end

  def show_cards(name, open=true)
    return puts "#{name} cards - #{cards.map { '*' }.join(' ')}" if open == false

    current_cards = cards.map { |card| "#{card.value}#{card.suit}" }.join(' ')
    puts "#{name} cards - #{current_cards}"
  end

  def reset
    self.cards = []
  end
end
