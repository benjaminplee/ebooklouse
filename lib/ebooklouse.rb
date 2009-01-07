require 'text_matrix_loader'
require 'dictionary'
require 'word_finder'

matrix = TextMatrixLoader.new.load_matrix(File.new(ARGV[0]))

dictionary = Dictionary.new
dictionary.load_word_list(File.new(ARGV[1]))

finder = WordFinder.new

words = finder.find_words(matrix, dictionary)

puts words
