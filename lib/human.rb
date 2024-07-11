# human player
class Human
  attr_accessor :guess

  def initialize
    @guess
  end

  def guess
    self.guess = gets.chomp.downcase
  end
end
