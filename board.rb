class Board
  GUESSES_AT_START = 9
  attr_reader :guesses_left, :bad_guesses, :correct_letters,
    :displayed_letters, :correct_indices

  def initialize(saved_game, new_word)
    if saved_game
      @guesses_left = saved_game['guesses_left']
      @bad_guesses = saved_game['bad_guesses']
      @correct_letters = saved_game['correct_letters']
      @displayed_letters = saved_game['displayed_letters']
    else
      @guesses_left = GUESSES_AT_START
      @bad_guesses = []
      @correct_letters = new_word.split('').map { |x| x.upcase }
      @displayed_letters = @correct_letters.map { '_' }
    end
  end
  
  def display_board
    puts "\nTHE WORD:\n#{@displayed_letters.join(' ')}\n\n"
  end
  
  def display_bad_guesses
    puts "Bad guesses (only #{@guesses_left} left!): #{@bad_guesses.join(', ')}"
  end
  
  def check_letter(guess)
    if @correct_letters.include?(guess)
      update_display(guess)
      puts "\n'#{guess}' is correct!"
    else
      @guesses_left -= 1
      @bad_guesses << guess
      puts "\nWhoops, '#{guess}' is incorrect!"
    end
  end
  
  def update_display(guess)
    @correct_indices = @correct_letters.each_index.select do |i|
      @correct_letters[i] == guess
    end
    @correct_indices.each { |i| @displayed_letters[i] = guess }
  end
  
  def win?
    if @displayed_letters == @correct_letters
      display_board
      puts '***** Congratulations, you win!! *****'
      return true
    end
  end
  
  def defeat?
    if @guesses_left == 0
      puts "\n***** Out of guesses, you lose!! *****
        \nTHE WORD was #{@correct_letters.join}"
      return true
    end
  end
end