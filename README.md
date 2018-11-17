# Hangman

Console version of the classic word-guessing game, with robust AI.

Play it here: https://repl.it/@karafto/hangman

Try the AI! It's almost impossible to lose.

![Hangman](hangman.png)

## Features

* The AI assistant is the centerpiece of the app. It first selects all words from the dictionary equal to the length of the mystery_word. Second, it defines a hash map where every letter points to a letter_count. Then it makes recursive calls to this algorithm:
  * In a nested loop, iterate through each word and each letter. If a word contains a letter, increment that letter's letter_count.
  * The guess is the letter with the highest letter_count.
  * Case: the guess is correct. The guess will match a certain index (or indices) in mystery_word. Eliminate all words that are missing the guess at that particular index.
  * Case: the guess is incorrect. Then eliminate all words that contain the guess (regardless of index).
  * Delete the guess from the hash of letters—it can't be chosen again.
  * Reset each letter_count to zero.
* User has the option to play solo or with assistance from the AI.
* In AI mode, user can override the AI and manually input a guess. Correct or not, the AI will continue to eliminate words accordingly.
* User can save and resume games in solo mode.

## Installation

Ensure that Ruby is installed on your machine.

Clone the repo: `$ git clone https://github.com/karafto/Hangman.git`

Move into the new directory: `$ cd hangman`

To play: `$ ruby hangman.rb`