class SoloPlayer
  attr_reader :alphabet
  
  def initialize(saved_game)
    @alphabet =
      if saved_game
        saved_game['alphabet']
      else
        ('A'..'Z').to_a
      end
  end

  def get_guess
    loop do
      puts "Enter letter or 'quit' to save and quit:"
      @guess = gets.strip.upcase
      return @guess if @alphabet.include?(@guess) || @guess == 'QUIT'
      puts "\nTry again! Use a valid letter that has yet to be guessed.\n\n"
    end
  end

  def eliminate_items(displayed_letters, correct_indices)
    @alphabet.delete(@guess)
  end
end