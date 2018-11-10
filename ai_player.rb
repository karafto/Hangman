class AiPlayer
  attr_reader :input, :words_with_same_length
  
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

    @input = @letter_counts.key(@letter_counts.values.max)
  end

  def get_input(display_letters, guess_count)
    unless guess_count == 9 && display_letters.all? { |x| x == '_' }
      if display_letters.include?(@input)
        @words_with_same_length.delete_if { |word| !word.include?(@input) }
      else
        @words_with_same_length.delete_if { |word| word.include?(@input) }
      end

      @letter_counts.delete(@input)
      find_most_included_letter(@words_with_same_length)
    end

    loop do
      puts "Press return for the letter '#{@input}':"
      @action = gets.strip
      break if @action.empty?
    end
  end
end