# computer player
# will pick random word
class Computer
  attr_accessor :guess, :words

  def initialize
    @guess
    @words
    set_words
  end

  def set_words
    words_file = File.read "google-10000-english-no-swears.txt"
    words = words_file.split
    words.filter! { |word| word.length.between?(5, 12) }
  end

  def pick_guess
    self.guess = words.sample
  end
end
npc = Computer.new
npc.set_words
p npc.guess
