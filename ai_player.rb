class AiPlayer
  attr_reader :guess, :potential_matches, :letter_counts
  
  def initialize(saved_game, new_word_length, word_list)
    if saved_game
      @potential_matches = saved_game['potential_matches']
      @letter_counts = saved_game['letter_counts']
    else
      @potential_matches = word_list.select do |word|
        word.length == new_word_length
      end
      @potential_matches.each { |word| word.upcase! }
      alphabet = ('A'..'Z').to_a
      @letter_counts = {}
      alphabet.each { |letter| @letter_counts[letter] = 0 }
    end
  end

  def get_guess
    @letter_with_max_count = find_most_included_letter(@potential_matches)
    loop do
      puts "Enter 'quit' to save and quit."
      puts "Enter letter or press return for '#{@letter_with_max_count}':"
      @guess = gets.strip.upcase
      if @letter_counts.include?(@guess) || @guess == 'QUIT' || @guess.empty?
        @guess = @letter_with_max_count if @guess.empty?
        break
      end
      puts "\nTry again! Use a valid letter that has yet to be guessed.\n\n"
    end
  end

  def eliminate_items(displayed_letters, correct_indices)
    if displayed_letters.include?(@guess)
      correct_indices.each do |i|
        @potential_matches.delete_if { |word| word[i] != @guess }
      end
    else
      @potential_matches.delete_if { |word| word.include?(@guess) }
    end
    @letter_counts.delete(@guess)
  end

  def find_most_included_letter(potential_matches)
    @letter_counts.each do |letter, count|
      @letter_counts[letter] = 0
      potential_matches.each do |word|
        @letter_counts[letter] += 1 if word.include?(letter)
      end
    end
    return @letter_counts.key(@letter_counts.values.max)
  end
end