$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'text_matrix_loader'

class TestTextMatrixLoader < Test::Unit::TestCase
  def test_sample_text_matrix
    matrix = [%w(a b c d), %w(e f g h i), %w(j k l m), %w(n o p q r), %w(s t u v), %w(w x y z a), %w(b c d e) ]

    result = TextMatrixLoader.new.load_matrix(File.new(File.dirname(__FILE__) + '/data/sample_text_matrix.txt'))

    assert_equal result, matrix
  end
end