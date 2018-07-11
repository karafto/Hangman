require './board'
require './player'

class Game
  def initialize
  	@dictionary = Dictionary.new
  	@board = Board.new(@dictionary.word)
  	@player = Player.new
  	play_game
  end
  
  def play_game
    until game_over
      @board.display_board
      @board.display_guesses
      @player.get_input
      @board.check_letter(@player.letter)
    end
  end
  
  def game_over
    @board.check_win || @board.check_defeat
  end
end

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

@game = Game.new