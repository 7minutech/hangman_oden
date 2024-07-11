require "pry-byebug"
# human player
class Human
  attr_accessor :guess

  def initialize
    @guess
  end

  def guess
    puts "Enter your guess: "
    self.guess = gets.chomp.downcase
    guess unless validate_guess
  end

  def validate_guess
    guess = guess[0]
    true if letter?(guess)
  end

  def letter?(letter)
    letter.match?(/[[:alpha:]]/)
  end
end
p1 = Human.new
p1.guess
binding.pry
p1.guess
