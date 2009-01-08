class Point
  attr_accessor :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def ==(other)
    other != nil and other.x == @x and other.y == @y
  end

  def to_s
    "(#{@x},#{@y})"
  end

end