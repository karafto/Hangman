require './game'
require './board'
require './solo_player'
require './ai_player'
require 'json'

class Hangman
  MIN_WORD_LENGTH = 6
  MAX_WORD_LENGTH = 12
  FILE = 'saved_data.json'

  def initialize
    puts "\n***** Welcome to HANGMAN! *****"
    dictionary = File.readlines('dictionary.txt').map { |entry| entry.strip }
    @word_list = dictionary.select do |word|
      word.length >= MIN_WORD_LENGTH && word.length <= MAX_WORD_LENGTH
    end
  end

  def master_loop
    loop do
      solo = solo_player?
      if solo && File.exist?(FILE)
        resume = resume_game?
      end
      game = Game.new(resume, solo, @word_list)
      game.play_game
      File.delete(FILE) if resume
    end
  end

  def solo_player?
    loop do
      puts "\nWould you like to play (s)olo or with (a)ssistance from the AI? (s/a):"
      @choice = gets.strip.downcase
      break if @choice == 's' || @choice == 'a'
    end
    return @choice == 's'
  end

  def resume_game?
    loop do
      puts "\nWould you like to (r)esume your saved game, or start a (n)ew one? (r/n):"
      @choice = gets.strip.downcase
      break if @choice == 'r' || @choice == 'n'
    end
    return @choice == 'r'
  end
end

hangman = Hangman.new
hangman.master_loop