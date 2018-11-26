class Game
  def initialize(resume, solo, word_list)
    if resume
      saved_game = JSON.parse(File.read('saved_game.json'))
    else
      new_word = word_list.sample
    end

    if solo
      @player = SoloPlayer.new(saved_game)
    else
      @player = AiPlayer.new(new_word.length, word_list)
      @player.find_most_included_letter(@player.words_with_same_length)
    end

    @board = Board.new(saved_game, new_word)
  end
  
  def play_game
    until @board.win? || @board.defeat?
      @board.display_board
      @board.display_bad_guesses
      @player.get_guess(@board.displayed_letters, @board.guesses_left,
        @board.correct_indices)
      check_save(@player.guess)
      @board.check_letter(@player.guess)
    end
  end

  def check_save(guess)
    if guess == 'QUIT'
      temp_hash = {
        guesses_left: @board.guesses_left,
        bad_guesses: @board.bad_guesses,
        correct_letters: @board.correct_letters,
        displayed_letters: @board.displayed_letters,
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