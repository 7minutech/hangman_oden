require "lib/computer"
require "lib/human"
# can play a game of hang man
class HangmanGame
  attr_accessor :player, :computer, :board

  def initialize
    @player = Human.new
    @computer = Computer.new
    @board
  end

  def set_hidden_word
    computer.pick_guess
  end

  def player_guess
    player.valid_guess
  end

  def display_baord
    p board
  end
end
