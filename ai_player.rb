class AiPlayer
  attr_reader :input
  
  def initialize(word_length)
    if word_length > 1
      @guesses = ['Y', 'B', 'H', 'G', 'M', 'P', 'U', 'D', 'C', 'L', 'O', 'T', 'N', 'R', 'A', 'I', 'S', 'E']
    end
  end

  def get_input
    @input = @guesses.pop
    loop do
      puts "Press enter for the letter '#{@input}':"
      @action = gets.strip.upcase
      break if @action.empty?
    end
  end
end