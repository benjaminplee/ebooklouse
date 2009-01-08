class TextMatrixLoader
  def load_matrix(text_file)
    text_file.collect { |line| line.chomp.split(' ') }
  end
end
