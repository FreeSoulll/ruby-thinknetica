# frozen_string_literal: true

require_relative 'card/card'
require_relative 'deck/deck'
require_relative 'player/player'
require_relative 'player/user'
require_relative 'player/dealer'

class Game
  attr_reader :player, :dealer, :deck
  attr_accessor :bank

  GAME_STEPS_TEXT = [
    'Enter 1 if you want to skip a move',
    'Enter 2 if you want to add a card',
    'Enter 3 if you want to open the cards'
  ].freeze

  def initialize
    puts 'Your name'
    @player_name = gets.chomp
    @player = User.new(@player_name)
    @dealer = Dealer.new
    @deck = Deck.new
    @bank = 0
  end

  def start
    loop do
      break if player.money.zero? || dealer.money.zero?

      player.bet
      dealer.bet
      self.bank += 20

      play_round
      puts "Your bank - #{player.money}"
      puts "Dealer bank - #{dealer.money}"
      puts 'Press 1 if you want to play again or 0 to exit'
      choose = gets.chomp.to_i
      break if choose.zero?
    end
  end

  private

  def play_round
    take_card(player, 2)
    take_card(dealer, 2)
    loop do
      player.show_cards('player')
      dealer.show_cards('dealer', false)

      puts "#{player.name} score - #{player.points}"
      puts GAME_STEPS_TEXT
      step = gets.chomp.to_i

      case step
      when 1
        dealer_turn
      when 2
        take_card(player) if player.cards.length < 3
        dealer_turn
        break
      when 3
        dealer_turn
        show_score
        break
      end
    end
    define_winner
    player.reset
    dealer.reset
  end

  def dealer_turn
    return if dealer.points > 17 || dealer.cards.length == 3

    take_card(dealer)
  end

  def take_card(user, count = 1)
    count.times do
      user.cards << deck.take_card
    end
  end

  def show_score
    puts "#{player.name} score - #{player.points}"
    puts "#{dealer.name} score - #{dealer.points}"
  end

  def define_winner
    player.show_cards('player')
    dealer.show_cards('dealer')
    show_score

    if player.points > 21 && dealer.points > 21
      puts 'draw!!!'
      player.money += 10
      dealer.money += 10
    elsif player.points > 21
      puts 'dealer win!!'
      dealer.money += self.bank
    elsif dealer.points > 21
      puts 'player win!!!'
      player.money += self.bank
    elsif player.points < dealer.points && dealer.points <= 21
      puts 'dealer win!!!'
      dealer.money += self.bank
    elsif player.points == dealer.points
      puts 'draw!!!'
      player.money += 10
      dealer.money += 10
    else
      puts 'player win!!!'
      player.money += self.bank
    end

    self.bank = 0
  end
end

game = Game.new
game.start
