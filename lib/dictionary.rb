class Dictionary
  def initialize
    @words = []
  end

  def empty?
    @words == []
  end

  def size
    @words.size
  end

  def load_word_list(word_list)
    word_list.each do |line|
      @words << line.chomp
    end
  end

  def lookup(candidate_word)
    result = Result.new

    @words.each do | word |
      result.was_found = true if word == candidate_word
      result.is_prefix = true if word != candidate_word and word.index(candidate_word) == 0
    end

    result
  end

  private

  class Result
    attr_accessor :was_found, :is_prefix

    def initialize
      @was_found = false
      @is_prefix = false
    end
  end
end
