class Board
  attr_reader :guesses_left, :display_incorrect, :word_letters, :display_letters

  def initialize(saved_game, new_word)
    if saved_game
      @guesses_left = saved_game['guesses_left']
      @display_incorrect = saved_game['display_incorrect']
      @word_letters = saved_game['word_letters']
      @display_letters = saved_game['display_letters']
    else
      @guesses_left = 9
      @display_incorrect = []
      @word_letters = new_word.split('').map { |x| x.upcase }
      @display_letters = @word_letters.map { '_' }
    end
  end
  
  def display_board
    puts "\nTHE WORD:\n#{@display_letters.join(' ')}\n\n"
  end
  
  def display_guesses
    puts "Bad guesses (only #{@guesses_left} left!): #{@display_incorrect.join(', ')}"
  end
  
  def check_letter(letter)
    if @word_letters.include?(letter)
      update_word(letter)
      puts "\nThat is correct!"
    else
      @guesses_left -= 1
      @display_incorrect << letter
      puts "\nWhoops, incorrect!"
    end
  end
  
  def update_word(letter)
    correct_indices = @word_letters.each_index.select { |i| @word_letters[i] == letter }
    correct_indices.each { |i| @display_letters[i] = letter }
  end
  
  def win?
    if @display_letters == @word_letters
      display_board
      puts 'Congratulations, you win!!'
      true
    end
  end
  
  def defeat?
    if @guesses_left == 0
      puts "\nOut of guesses, you lose!\n\nTHE WORD was #{@word_letters.join}."
      true
    end
  end
end