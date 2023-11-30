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
      card.value.to_i == 0 ? points += 1 : points += card.value
    end
    points
  end

  def bet
    self.money -= 10
  end
end

class Dealer < Player
  def name
    "Dealer"
  end
end

class User < Player
  def initialize(name)
    super()
    @name = name
  end
end

class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end

class Deck
  attr_accessor :cards

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

  def generate_deck
    SUITS.each do |suit|
      VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle!
  end
end

class Game
  attr_reader :player, :dealer, :deck
  attr_accessor :bank
 
  def initialize
    puts "Your name"
    @player_name = gets.chomp
    @player = User.new(@player_name)
    @dealer = Dealer.new
    @deck = Deck.new
    @bank = 0
  end

  def start
    player.bet
    puts "palyer money - #{player.money}"
    dealer.bet
    puts "dealer money - #{dealer.money}"
    self.bank += 20
    puts "bank #{bank}"
    play_round
    define_winner
  end

  def play_round
    take_cards
    second_step
    puts "Ваша сумма - #{player.points}"
  end

  private
  
  def second_step
   player.cards << deck.take_card if player.points < 17
   dealer.cards << deck.take_card if dealer.points < 17
  end

  def take_cards
    player.cards << deck.take_card
    player.cards << deck.take_card
    dealer.cards << deck.take_card
    dealer.cards << deck.take_card
  end

  def define_winner
    puts "player.points #{player.points}"
    puts "dealer.points #{dealer.points}"
     
    if player.points < dealer.points
      puts 'dealer win'
    elsif player.points == dealer.points
      puts 'draw'
    else
      puts 'player win'
    end
  end
end

game = Game.new()
game.start


#user = User.new('pepe')
#user.bet
