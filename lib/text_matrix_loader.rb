class TextMatrixLoader
  def load_matrix(text)
    text.collect { |line| line.chomp.split(' ') }
  end
end