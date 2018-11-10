class Board
  attr_reader :guess_count, :bad_guesses, :correct_letters, :displayed_letters

  def initialize(saved_game, new_word)
    if saved_game
      @guess_count = saved_game['guess_count']
      @bad_guesses = saved_game['bad_guesses']
      @correct_letters = saved_game['correct_letters']
      @displayed_letters = saved_game['displayed_letters']
    else
      @guess_count = 9
      @bad_guesses = []
      @correct_letters = new_word.split('').map { |x| x.upcase }
      @displayed_letters = @correct_letters.map { '_' }
    end
  end
  
  def display_board
    puts "\nTHE WORD:\n#{@displayed_letters.join(' ')}\n\n"
  end
  
  def display_bad_guesses
    puts "Bad guesses (only #{@guess_count} left!): #{@bad_guesses.join(', ')}"
  end
  
  def check_letter(letter)
    if @correct_letters.include?(letter)
      update_word(letter)
      puts "\nThat is correct!"
    else
      @guess_count -= 1
      @bad_guesses << letter
      puts "\nWhoops, incorrect!"
    end
  end
  
  def update_word(letter)
    correct_indices = @correct_letters.each_index.select { |i| @correct_letters[i] == letter }
    correct_indices.each { |i| @displayed_letters[i] = letter }
  end
  
  def win?
    if @displayed_letters == @correct_letters
      display_board
      puts 'Congratulations, you win!!'
      true
    end
  end
  
  def defeat?
    if @guess_count == 0
      puts "\nOut of guesses, you lose!\n\nTHE WORD was #{@correct_letters.join}."
      true
    end
  end
end