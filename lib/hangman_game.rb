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
end
