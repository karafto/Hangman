class Game
  def initialize(resume, human, word_list)
    if resume
      saved_game = JSON.parse(File.read('saved_game.json'))
    else
      new_word = word_list.sample
    end
    @board = Board.new(saved_game, new_word)

    if human
      @player = HumanPlayer.new(saved_game)
    else
      @player = AiPlayer.new(new_word.length, word_list)
      @player.find_most_included_letter(@player.words_with_same_length)
    end
  end
  
  def play_game
    until @board.win? || @board.defeat?
      @board.display_board
      @board.display_guesses
      @player.get_input(@board.display_letters, @board.guess_count)
      check_save(@player.input)
      @board.check_letter(@player.input)
    end
  end

  def check_save(input)
    if input == 'QUIT'
      temp_hash = {
        guess_count: @board.guess_count,
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
end