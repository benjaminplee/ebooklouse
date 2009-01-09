require 'text_matrix_loader'
require 'dictionary'
require 'word_finder'
require 'desktop'

matrix = TextMatrixLoader.new.load_matrix(File.new(ARGV[0]))

dictionary = Dictionary.new
dictionary.load_word_list(File.new(ARGV[1]))

finder = WordFinder.new

words = finder.find_words(matrix, dictionary)

words.each { |word| puts "- #{word.string}  [#{word.path.join(', ').to_s}]" }

image = Desktop.new.capture_desktop
puts image.pixel(1, 1).inspect
puts image.width
puts image.height