require "lib/computer"
require "lib/human"
# can play a game of hang man
class HangmanGame
  attr_accessor :player, :computer, :board, :strikes

  def initialize
    @player = Human.new
    @computer = Computer.new
    @board
    @strikes = []
  end

  def set_hidden_word
    computer.pick_guess
  end

  def player_guess
    player.valid_guess
  end

  def set_baord
    self.board = Array.new(computer.guess, " ")
  end

  def display_baord
    p board
  end

  def correct_guess?
    true if computer.guess.include?(player.guess)
  end

  def fill_correct_guess
    computer.guess.each_with_index do |guess, index|
      board[index] = guess if guess == player.guess
    end
  end

  def fill_strikes
    strikes.push("x")
  end

  def play_round
    display_baord
    player_guess
    if correct_guess?
      fill_correct_guess
    else
      fill_strikes
    end
  end
end
