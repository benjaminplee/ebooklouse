$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'word_finder'

class LoggingDictionary < Dictionary
  attr_reader :words_looked_up

  def initialize
    super()
    @words_looked_up = []
  end

  def lookup(candidate_word)
    @words_looked_up << candidate_word

    super(candidate_word)
  end
end

class AllPrefixDictionary < LoggingDictionary
  def lookup(candidate_word)
    super(candidate_word)
    return LookupResult.new(false, true)
  end
end

class TestWordFinder < Test::Unit::TestCase
  def setup
    @finder = WordFinder.new
    @matrix = [['a'], ['b', 'c'], ['d']]
    @dictionary = LoggingDictionary.new
  end

  def test_bottom_right
    assert_equal Point.new(1, 0), @finder.bottom_right(Point.new(0, 0), @matrix)
    assert_nil @finder.bottom_right(Point.new(1, 0), @matrix)
    assert_equal Point.new(2, 0), @finder.bottom_right(Point.new(1, 1), @matrix)
    assert_nil @finder.bottom_right(Point.new(2, 0), @matrix)
  end

  def test_top_right
    assert_equal Point.new(1, 1), @finder.top_right(Point.new(0, 0), @matrix)
    assert_equal Point.new(2, 0), @finder.top_right(Point.new(1, 0), @matrix)
    assert_nil @finder.top_right(Point.new(1, 1), @matrix)
    assert_nil @finder.top_right(Point.new(2, 0), @matrix)
  end

  def test_top_left
    assert_nil @finder.top_left(Point.new(0, 0), @matrix)
    assert_equal Point.new(0, 0), @finder.top_left(Point.new(1, 0), @matrix)
    assert_nil @finder.top_left(Point.new(1, 1), @matrix)
    assert_equal Point.new(1, 1), @finder.top_left(Point.new(2, 0), @matrix)
  end

  def test_bottom_left
    assert_nil @finder.bottom_left(Point.new(0, 0), @matrix)
    assert_nil @finder.bottom_left(Point.new(1, 0), @matrix)
    assert_equal Point.new(0, 0), @finder.bottom_left(Point.new(1, 1), @matrix)
    assert_equal Point.new(1, 0), @finder.bottom_left(Point.new(2, 0), @matrix)
  end

  def test_above
    assert_nil @finder.above(Point.new(0, 0), @matrix)
    assert_equal Point.new(1, 1), @finder.above(Point.new(1, 0), @matrix)
    assert_nil @finder.above(Point.new(1, 1), @matrix)
    assert_nil @finder.above(Point.new(2, 0), @matrix)
  end

  def test_below
    assert_nil @finder.below(Point.new(0, 0), @matrix)
    assert_nil @finder.below(Point.new(1, 0), @matrix)
    assert_equal Point.new(1, 0), @finder.below(Point.new(1, 1), @matrix)
    assert_nil @finder.below(Point.new(2, 0), @matrix)
  end

  def test_looks_up_correct_single_letter_words
    @dictionary.load_word_list(['a', 'b', 'c', 'd'])

    words = @finder.find_words(@matrix, @dictionary)

    assert_equal(['a', 'b', 'c', 'd'], words)
    assert_equal(['a', 'b', 'c', 'd'], @dictionary.words_looked_up)
  end

  def test_looks_up_all_possible_with_prefix_from_a
    word_list = %w(a ab abc abcd abd abdc ac acb acbd acd acdb)
    @dictionary.load_word_list(word_list)

    words = @finder.find_words(@matrix, @dictionary)

    assert_equal(14, @dictionary.words_looked_up.size)
    assert_equal(word_list, words)
  end

  def test_looks_up_all_prefixed_without_cycles
    dictionary = AllPrefixDictionary.new

    words = @finder.find_words(@matrix, dictionary)

    assert_equal(42, dictionary.words_looked_up.size)
    assert_equal([], words)
  end

  def test_finds_all_single_letter_words
    @dictionary.load_word_list(['a', 'b', 'c', 'd'])

    words = @finder.find_words(@matrix, @dictionary)

    assert_equal(['a', 'b', 'c', 'd'], words)
  end

  def test_finds_different_single_letter_words
    @dictionary.load_word_list(['a', 'b', 'c', 'd'])

    words = @finder.find_words([['a'], ['c', 'b'], ['d']], @dictionary)

    assert_equal(['a', 'c', 'b', 'd'], words)
  end
  
end
