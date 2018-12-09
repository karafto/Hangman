require './board'
require './solo_player'
require './ai_player'
require 'json'

class Hangman
  MIN_WORD_LENGTH = 6
  MAX_WORD_LENGTH = 12
  SOLO = 'solo_game_data.json'
  AI = 'ai_game_data.json'

  def initialize
    puts "\n***** Welcome to HANGMAN! *****"
    dictionary = File.readlines('dictionary.txt').map { |entry| entry.strip }
    @word_list = dictionary.select do |word|
      word.length >= MIN_WORD_LENGTH && word.length <= MAX_WORD_LENGTH
    end
  end

  def master_loop
    loop do
      setup_game
      play_game
      File.delete(@mode) if @resume
    end
  end

  def setup_game
    @mode = solo_player? ? SOLO : AI
    @resume = File.exist?(@mode) ? resume_game? : false
    if @resume
      saved_game = JSON.parse(File.read(@mode))
    else
      new_word = @word_list.sample
      new_word_length = new_word.length
    end

    @board = Board.new(saved_game, new_word)
    @player =
      if @mode == SOLO
        SoloPlayer.new(saved_game)
      else
        AiPlayer.new(saved_game, new_word_length, @word_list)
      end
  end

  def play_game
    until @board.win? || @board.defeat?
      @board.display_board
      @board.display_bad_guesses
      guess = @player.get_guess
      save_and_quit if guess == 'QUIT'
      @board.check_letter(guess)
      @player.eliminate_items(@board.displayed_letters, @board.correct_indices)
    end
  end

  def save_and_quit
    game_data = {
      guesses_left: @board.guesses_left,
      bad_guesses: @board.bad_guesses,
      correct_letters: @board.correct_letters,
      displayed_letters: @board.displayed_letters
    }
    if @mode == SOLO
      game_data[:alphabet] = @player.alphabet
    else
      game_data[:potential_matches] = @player.potential_matches
      game_data[:letter_counts] = @player.letter_counts
    end
    File.open(@mode,'w') do |f|
      f.write(JSON.pretty_generate(game_data))
    end
    puts "\nYour game has been saved. Bye!"
    exit
  end

  def solo_player?
    loop do
      puts "\nWould you like to play (s)olo or with (a)ssistance from the AI? (s/a):"
      choice = gets.strip.downcase
      return choice == 's' if choice == 's' || choice == 'a'
    end
  end

  def resume_game?
    loop do
      puts "\nWould you like to (r)esume your saved game, or start a (n)ew one? (r/n):"
      choice = gets.strip.downcase
      return choice == 'r' if choice == 'r' || choice == 'n'
    end
  end
end

hangman = Hangman.new
hangman.master_loop