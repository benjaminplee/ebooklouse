class Tile
  attr_reader :letter, :tile_type
  
  def initialize(letter)
    @letter = letter
    @tile_type = :normal
  end
end
