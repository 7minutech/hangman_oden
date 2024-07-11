require "pry-byebug"
# human player
class Human
  attr_accessor :guess, :used_guesses

  def initialize
    @guess
    @used_guesses = []
  end

  def enter_guess
    puts "Enter your guess: "
    self.guess = gets.chomp.downcase[0]
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
    used_guesses.push(guess)
  end

  def valid_guess
    loop do
      enter_guess
      break if validate_guess
    end
    add_guess_to_used
  end
end
p1 = Human.new
p1.valid_guess
p1.valid_guess
p1.valid_guess

puts "fd"
