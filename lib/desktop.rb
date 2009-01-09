require 'image'
require 'java'

include_class 'java.awt.Robot'
include_class 'java.awt.Toolkit'
include_class 'java.awt.Rectangle'

class Desktop
  def capture_desktop
    Image.new(Robot.new.create_screen_capture(Rectangle.new(Toolkit.default_toolkit.screen_size)))
  end
end


