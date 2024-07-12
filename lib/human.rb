require "pry-byebug"
# human player
class Human
  attr_accessor :guess, :used_guesses

  def initialize(used_guesses = [])
    @guess
    @used_guesses = []
  end

  def enter_guess
    puts "Enter your guess: "
    self.guess = gets.chomp
    self.guess = guess[0] unless guess == "save"
  end

  def validate_guess
    if !guess.nil? && letter?(guess) && !used_guesses.include?(guess)
      true
    else
      puts "Invalid guess, please enter a valid guess"
      false
    end
  end

  def letter?(letter)
    letter.match?(/[[:alpha:]]/)
  end

  def add_guess_to_used
    used_guesses.push(guess) unless guess == "save"
  end

  def valid_guess
    loop do
      enter_guess
      break if validate_guess
    end
    add_guess_to_used
  end

  def display_guesses
    puts "past gueeses: #{used_guesses}"
  end

  def reset
    self.used_guesses = []
  end
end
