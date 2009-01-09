$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'text_matrix_loader'
require 'dictionary'
require 'word_finder'

class TestTextMatrixLoader < Test::Unit::TestCase
  def test_sample_text_matrix
    matrix = [%w(a b c d), %w(e f g h i), %w(t h e m), %w(n o p e r), %w(s t u v), %w(t h e i r), %w(b c d e) ]

    result = TextMatrixLoader.new.load_matrix(File.new(File.dirname(__FILE__) + '/data/sample_text_matrix.txt'))

    assert_equal matrix, result.collect { |col| col.collect { |tile| tile.letter } }
  end

  def test_text_matrix_assumes_normal_tiles
    matrix = [Array.new(4, :normal), Array.new(5, :normal), Array.new(4, :normal), Array.new(5, :normal), Array.new(4, :normal), Array.new(5, :normal), Array.new(4, :normal)]

    result = TextMatrixLoader.new.load_matrix(File.new(File.dirname(__FILE__) + '/data/sample_text_matrix.txt'))

    assert_equal matrix, result.collect { |col| col.collect { |tile| tile.tile_type } }
  end

  def test_end_to_end_test
    matrix = TextMatrixLoader.new.load_matrix(File.new(File.dirname(__FILE__) + '/data/sample_text_matrix.txt'))
    dictionary = Dictionary.new
    dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/word_list.txt'))

    words = WordFinder.new.find_words(matrix, dictionary)

    assert_equal 34, words.size
  end
end
