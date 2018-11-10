class SoloPlayer
  attr_reader :guess, :alphabet
  
  def initialize(saved_game)
    if saved_game
      @alphabet = saved_game['alphabet']
    else
      @alphabet = ('A'..'Z').to_a
    end
  end

  def get_guess(display_letters, guess_count)
    loop do
      puts "Enter letter or 'quit' to save and quit:"
      @guess = gets.strip.upcase
      break if @alphabet.include?(@guess) || @guess == 'QUIT'
      puts "\nTry again! Use a valid letter that has yet to be guessed."
    end
    @alphabet.delete(@guess)
  end
end