class Player
  attr_reader :letter
  
  def initialize
    @alphabet = ('A'..'Z').to_a
  end
  
  def get_input
    puts "Enter letter:"
    @letter = gets.strip.upcase
    check_input
  end
  
  def check_input
    if @alphabet.include?(@letter)
      @alphabet.delete(@letter)
    else
      puts "\nTry again! Use a valid letter that has yet to be guessed."
      get_input
    end
  end
end