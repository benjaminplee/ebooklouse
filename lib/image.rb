require 'pixel'

class Image
  def initialize(source)
    @source = source.raster
  end

  def pixel(x, y)
    Pixel.new(@source.get_pixel(x, y, [0, 0, 0].to_java(:int)))
  end

  def width
    @source.width
  end

  def height
    @source.height
  end
end
