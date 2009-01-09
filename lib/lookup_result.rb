class LookupResult
  attr_accessor :was_found, :is_prefix

  def initialize(was_found = false, is_prefix = false)
    @was_found = was_found
    @is_prefix = is_prefix
  end
end