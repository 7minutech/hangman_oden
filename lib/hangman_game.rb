require "pry-byebug"
require_relative "computer"
require_relative "human"
# can play a game of hang man
class HangmanGame
  attr_accessor :player, :computer, :board, :strikes, :game_over, :play_again

  def initialize
    @player = Human.new
    @computer = Computer.new
    @board
    @strikes = []
    @game_over = false
    @play_again = false
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
    puts "-" * computer.guess.length * 6
    puts "Word: #{board}"
  end

  def display_strikes
    puts "stirkes: #{strikes}"
  end

  def display_past_guesses
    player.display_guesses
  end

  def display_boards
    display_baord
    display_strikes
    display_past_guesses
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
    # p computer.guess
    display_boards
    player_guess
    if correct_guess?
      fill_correct_guess
    else
      fill_strikes
    end
    game_over?
  end

  def game_over?
    if strikes.length == 5
      display_boards
      self.game_over = true
      puts "You lost! The word was #{computer.guess}"
    elsif board == computer.guess
      fill_correct_guess
      display_boards
      self.game_over = true
      puts "You win!"
    end
  end

  def reset?
    puts "Do you want to play again?"
    puts "Enter (y/n)"
    input = gets.chomp.downcase
    self.play_again = true if input == "y"
  end

  def reset
    player.reset
    computer.reset
    self.play_again = false
  end

  def play_game
    set_hidden_word
    set_baord
    play_round while game_over == false
    reset?
    reset if play_again == true
  end
end
