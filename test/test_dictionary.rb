$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'dictionary'

class TestDictionary < Test::Unit::TestCase
  def setup
    @dictionary = Dictionary.new
  end

  def test_new_dictionary_is_empty
    assert @dictionary.empty?
  end

  def test_new_dictionary_has_size_zero
    assert_equal 0, @dictionary.size
  end

  def test_not_empty_after_load
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/sample_word_list.txt'))

    assert !@dictionary.empty?
  end

  def test_appropriate_size_after_load
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/sample_word_list.txt'))

    assert_equal 20, @dictionary.size
  end

  def test_load_is_additive
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/sample_word_list.txt'))
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/small_word_list.txt'))

    assert_equal 25, @dictionary.size
  end
  
  def test_words_in_list_can_be_found
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/sample_word_list.txt'))

    assert @dictionary.lookup('dog').was_found
    assert @dictionary.lookup('cat').was_found
    assert @dictionary.lookup('canary').was_found
    assert @dictionary.lookup('wall').was_found
    assert @dictionary.lookup('window').was_found
    assert @dictionary.lookup('tip').was_found
  end

  def test_other_words_are_not_there
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/sample_word_list.txt'))

    assert !@dictionary.lookup('bird').was_found
    assert !@dictionary.lookup('hose').was_found
    assert !@dictionary.lookup('snow').was_found
    assert !@dictionary.lookup('their').was_found
    assert !@dictionary.lookup('wow').was_found
    assert !@dictionary.lookup('mule').was_found
  end

  def test_lookup_works_on_both_files
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/sample_word_list.txt'))
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/small_word_list.txt'))

    assert @dictionary.lookup('dog').was_found
    assert @dictionary.lookup('cat').was_found
    assert @dictionary.lookup('fear').was_found
    assert @dictionary.lookup('bear').was_found
  end

  def test_lookup_finds_prefixes
    @dictionary.load_word_list(File.new(File.dirname(__FILE__) + '/../data/sample_word_list.txt'))

    assert !@dictionary.lookup('dog').is_prefix
    assert @dictionary.lookup('t').is_prefix
    assert @dictionary.lookup('the').is_prefix
    assert @dictionary.lookup('the').was_found
    assert @dictionary.lookup('sl').is_prefix
    assert !@dictionary.lookup('wall').is_prefix
  end
end
