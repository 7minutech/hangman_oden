require "pry-byebug"
require_relative "computer"
require_relative "human"
require "json"
# can play a game of hang man
class HangmanGame
  attr_accessor :player, :computer, :board, :strikes, :game_over, :play_again, :loaded

  def initialize(player = Human.new, computer = Computer.new, board = [],
                 strikes = [], game_over = false, play_again = false, loaded = false)
    @player = player
    @computer = computer
    @board = board
    @strikes = strikes
    @game_over = game_over
    @play_again = play_again
    @loaded = loaded
  end

  def set_hidden_word
    computer.pick_guess
  end

  def player_guess
    player.valid_guess
  end

  def set_baord
    self.board = Array.new(computer.guess.length, " ") if board.empty? || player.used_guesses.empty?
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
    true if computer.guess.include?(player.guess) || player.guess == "save"
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
    p computer.guess
    display_boards
    player_guess
    if correct_guess?
      if player.guess == "save"
        save_game
      else
        fill_correct_guess
      end
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
    self.strikes = []
    self.game_over = false
    self.play_again = false
    play_game
  end

  def play_game
    laod_game
    puts "To save the game enter \"save\""
    set_hidden_word
    set_baord
    play_round while game_over == false
    reset?
    reset if play_again == true
  end

  def to_json(*_args)
    game_contents = JSON.dump(
      {
        player: @player.used_guesses,
        computer: @computer.guess,
        board: @board,
        strikes: @strikes,
        game_over: @game_over,
        play_again: @play_again,
        loaded: @loaded
      }
    )
    game_save_file = File.open("game_save.json", "w")
    game_save_file.puts game_contents
  end

  def self.from_json
    game_file_data = File.read("game_save.json")
    game_data = JSON.parse game_file_data
    new(Human.new(game_data["player"]), Computer.new(game_data["computer"]), game_data["board"],
        game_data["strikes"], game_data["game_over"], game_data["play_again"], "true")
  end

  def save_game
    to_json
    puts "Saving game..."
  end

  def laod_game
    return unless File.exist?("game_save.json") && loaded == false

    puts "Do you want to load your last game?"
    puts "Enter (y/n)"
    return unless gets.chomp.downcase == "y"

    puts "Loading game..."
    saved_game = HangmanGame.from_json
    saved_game.play_game
  end
end
