require 'tile'

class TextMatrixLoader
  def load_matrix(text_file)
    text_file.collect { |line| line.chomp.split(' ').collect { |letter| Tile.new(letter) } }
  end
end
