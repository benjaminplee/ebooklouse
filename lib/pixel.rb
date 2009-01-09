class Pixel
  attr_reader :red, :green, :blue

  def initialize(pixel_array)
    @red = pixel_array[0]
    @green = pixel_array[1]
    @blue = pixel_array[2]
  end
end
