class Word
  attr_accessor :string, :path

  def initialize(string = "", path = [])
    @string = string
    @path = path
  end
end
