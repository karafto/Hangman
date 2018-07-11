require 'yaml'

class Game
  def initialize
    resume?
  end
  def resume?
  	puts "Enter 'r' to resume a saved game."
  	puts "Enter 'n' to start a new game (this will delete any saved game):"
    response = gets.chomp
    if response == 'r'
      yaml_load
      play_game
	elsif response == 'n'
	  setup_game
    else
      puts "\nTry again!"
      resume?
    end
  end
  def yaml_load
  	objects = YAML.load(File.read("saved_game.txt"))
  	@board = objects[0]
  	@player = objects [1]
  end
  def yaml_save(board, player)
  	objects = [board, player]
  	File.open('saved_game.txt', 'w') do |f|
      f.write(objects.to_yaml)
    end
  end
  def setup_game
  	@dictionary = Dictionary.new
  	@board = Board.new(@dictionary.word)
  	@player = Player.new
  	play_game
  end
  def play_game
    until game_over
      @board.display_board
      @board.display_guesses
      yaml_save(@board, @player)
      @player.get_input
      @board.check_letter(@player.letter)
    end
  end
  def game_over
    @board.check_win || @board.check_defeat
  end
end