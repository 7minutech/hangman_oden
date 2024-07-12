require "pry-byebug"
# computer player
# will pick random word
class Computer
  attr_accessor :guess, :words

  def initialize(guess: "")
    @guess
    @words
    set_words
  end

  def set_words
    words_file = File.read "google-10000-english-no-swears.txt"
    self.words = words_file.split
    words.filter! { |word| word.length.between?(5, 12) }
  end

  def pick_guess
    self.guess = words.sample.chars
  end

  def display_guess
    p guess
  end

  def reset
    pick_guess
  end
end
