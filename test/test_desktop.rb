$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'desktop'

class TestDesktop < Test::Unit::TestCase
  def test_can_capture_desktop
    desktop = Desktop.new

    image = desktop.capture_desktop

    width = image.width
    height = image.height

    (0...width).each do |x|
      (0...height).each do |y|
        pixel = image.pixel(x, y)
      end
    end
  end
end
