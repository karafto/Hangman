class HumanPlayer
  attr_reader :input, :alphabet
  
  def initialize(saved_game)
    if saved_game
      @alphabet = saved_game['alphabet']
    else
      @alphabet = ('A'..'Z').to_a
    end
  end

  def get_input
    loop do
      puts "Enter letter or 'quit' to save and quit:"
      @input = gets.strip.upcase
      break if @alphabet.include?(@input) || @input == 'QUIT'
      puts "\nTry again! Use a valid letter that has yet to be guessed."
    end
    @alphabet.delete(@input)
  end
end