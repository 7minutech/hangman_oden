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
    self.guess = gets.chomp.downcase
    enter_guess until validate_guess
  end

  def validate_guess
    self.guess = guess[0]
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
end
p1 = Human.new
p1.enter_guess
binding.pry
puts "fd"
