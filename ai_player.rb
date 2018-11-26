class AiPlayer
  attr_reader :guess, :words_with_same_length
  
  def initialize(new_word_length, word_list)
    @words_with_same_length = word_list.select do |word|
      word.length == new_word_length
    end
    @words_with_same_length.each { |word| word.upcase! }
    alphabet = ('A'..'Z').to_a
    @letter_counts = {}
    alphabet.each { |letter| @letter_counts[letter] = 0 }
  end

  def find_most_included_letter(words_with_same_length)
    @letter_counts.each do |letter, count|
      words_with_same_length.each do |word|
        @letter_counts[letter] += 1 if word.include?(letter)
      end
    end

    @guess = @letter_counts.key(@letter_counts.values.max)
  end

  def get_guess(displayed_letters, guesses_left, correct_indices)
    unless guesses_left == 9 && displayed_letters.all? { |x| x == '_' }
      if displayed_letters.include?(@guess)
        correct_indices.each do |i|
          @words_with_same_length.delete_if { |word| word[i] != @guess }
        end
      else
        @words_with_same_length.delete_if { |word| word.include?(@guess) }
      end

      @letter_counts.delete(@guess)
      @letter_counts.each { |letter, count| @letter_counts[letter] = 0 }
      find_most_included_letter(@words_with_same_length)
    end

    loop do
      puts "Enter letter or press return '#{@guess}':"
      @input = gets.strip.upcase
      break if @input.empty?
      if @letter_counts.include?(@input)
        @guess = @input
        break
      end
      puts "\nTry again! Use a valid letter that has yet to be guessed."
    end
  end
end