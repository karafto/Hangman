class Board 
  def initialize(word)
  	@guesses = 9
    @display_incorrect = []
    @word_letters = word.split('').map { |x| x.upcase }
    @display_letters = @word_letters.map { '_' }
  end
  
  def display_board
    puts "\nTHE WORD:\n#{@display_letters.join(' ')}\n\n"
  end
  
  def display_guesses
    puts "Bad guesses (only #{@guesses} left!): #{@display_incorrect.join(', ')}"
  end
  
  def check_letter(letter)
    if @word_letters.include?(letter)
      update_word(letter)
      puts "\nThat is correct!"
    else
      @guesses -= 1
      @display_incorrect << letter
      puts "\nWhoops, incorrect!"
    end
  end
  
  def update_word(letter)
    correct_letters = @word_letters.each_index.select { |i| @word_letters[i] == letter }
    correct_letters.each { |v| @display_letters[v] = letter }
  end
  
  def check_win
    if @display_letters == @word_letters
      display_board
      puts 'Congratulations, you win!'
      true
    end
  end
  
  def check_defeat
    if @guesses == 0
      puts "\nOut of guesses, you lose!\n\nTHE WORD was #{@word_letters.join}."
      true
    end
  end
end