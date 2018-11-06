class Game
  def initialize(eligible_words)
    choose_game
    setup_game(@resume, eligible_words)
    play_game
  end

  def choose_game
    if !File.exist?('saved_game.json')
      @resume = false
    else
      loop do
        puts "\nWould you like to (r)esume your saved game, or start a (n)ew one? (r/n):"
        @choice = gets.strip.downcase
        break if @choice == 'r' || @choice == 'n'
      end
      @choice == 'r' ? @resume = true : @resume = false
    end
  end

  def setup_game(resume, eligible_words)
    if resume
      saved_game = JSON.parse(File.read('saved_game.json'))
    else
      new_word = eligible_words.sample
    end
    @board = Board.new(saved_game, new_word)
    @player = Player.new(saved_game)
  end
  
  def play_game
    until game_over?
      @board.display_board
      @board.display_guesses
      @player.get_input
      check_save(@player.input)
      @board.check_letter(@player.input)
    end
  end

  def check_save(input)
    if input == 'QUIT'
      temp_hash = {
        guesses_left: @board.guesses_left,
        display_incorrect: @board.display_incorrect,
        word_letters: @board.word_letters,
        display_letters: @board.display_letters,
        alphabet: @player.alphabet
      }
      File.open('saved_game.json','w') do |f|
        f.write(temp_hash.to_json)
      end
      puts "\nYour game has been saved. Bye!"
      exit
    end
  end
  
  def game_over?
    @board.win? || @board.defeat?
  end
end