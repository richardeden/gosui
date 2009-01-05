require 'rubygems'
require 'gosu'
require 'RMagick'
require 'gosui'

class ExampleWindow < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = 'Gosui Example'
    @cursor = Gosui::Mouse_Pointer.new(self)
  end
  
  def draw
    @cursor.draw
  end
end

ExampleWindow.new.show