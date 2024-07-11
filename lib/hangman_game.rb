require "pry-byebug"
require_relative "computer"
require_relative "human"
# can play a game of hang man
class HangmanGame
  attr_accessor :player, :computer, :board, :strikes, :game_over

  def initialize
    @player = Human.new
    @computer = Computer.new
    @board
    @strikes = []
    @game_over = false
  end

  def set_hidden_word
    computer.pick_guess
  end

  def player_guess
    player.valid_guess
  end

  def set_baord
    self.board = Array.new(computer.guess.length, " ")
  end

  def display_baord
    p board
  end

  def display_strikes
    p strikes
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
    game_over?
    display_baord
    display_strikes
    player_guess
    if correct_guess?
      fill_correct_guess
    else
      fill_strikes
    end
  end

  def game_over?
    if strikes.length == 5
      self.game_over = true
    elsif board == computer.guess
      self.game_over = true
    end
  end

  def play_game
    set_hidden_word
    set_baord
    play_round while game_over == false
  end
end
game1 = HangmanGame.new
game1.play_game
