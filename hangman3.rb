require './hangman2'

class Dictionary
  attr_reader :word
  def initialize
  	@list = File.readlines('dictionary.txt')
    select_random
  end
  def select_random
    @word = @list.sample
    check_length
  end
  def check_length
  	@word.strip!
  	unless @word.length > 4 && @word.length < 13
  	  select_random
  	end
  end
end

class Player
  attr_reader :letter
  def initialize
    @alphabet = ('A'..'Z').to_a
  end
  def get_input
    puts "Enter next letter, or 'ctrl + d' to save and quit:"
    @letter = gets.strip.upcase
    check_input
  end
  def check_input
    if @alphabet.include?(@letter)
      @alphabet.delete(@letter)
    else
      puts "\nTry again! Use a valid letter that has yet to be guessed."
      get_input
    end
  end
end

@game = Game.new