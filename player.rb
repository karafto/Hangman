class Player
  attr_reader :letter
  
  def initialize
    @alphabet = ('A'..'Z').to_a
  end
  
  def get_input
    loop do    
      puts "Enter letter:"
      @letter = gets.strip.upcase
      break if @alphabet.include?(@letter)
      puts "\nTry again! Use a valid letter that has yet to be guessed."
    end
    @alphabet.delete(@letter)  
  end
end