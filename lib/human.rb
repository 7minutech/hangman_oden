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
  end
end
p1 = Human.new
p1.guess
binding.pry
p1.guess
