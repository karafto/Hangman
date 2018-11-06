require './game'
require './board'
require './player'
require 'json'

puts "\nWelcome to HANGMAN!"

word_list = File.readlines('dictionary.txt').map { |entry| entry.strip }
eligible_words = word_list.select { |word| word.length > 4 && word.length < 13 }

loop do
  game = Game.new(eligible_words)
end