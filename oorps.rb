class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def display_winning_message
    case @value
    when 'p'
      puts "Paper wraps rock!"
    when 'r'
      puts "Rock smashes scissors!"
    when 's'
      puts "Scissors cuts paper!"
    end
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') || (@value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end
end
      

class Player
  include Comparable

  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{name} chooses #{self.hand.value}."
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Pick one: (r, p, s)"
      c = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(c)

    self.hand = Hand.new(c)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

class Game
  CHOICES = { "p" => "Paper", "r" => "Rock", "s" => "Scissors" }

  attr_reader :player, :computer

  def initialize
    print 'Name? >'
    name = gets.chomp.split.map(&:capitalize).join(' ')
    @player = Human.new(name)
    @computer = Computer.new('R2D2')
  end

  def compare_hands
    if player.hand == computer.hand
      puts "TIE"
    elsif player.hand > computer.hand
      puts player
      puts computer
      player.hand.display_winning_message
    else
      computer.hand.display_winning_message
      puts player
      puts computer
    end
  end

  def play
    player.pick_hand
    computer.pick_hand
    compare_hands
  end

end

game = Game.new.play