require 'rubygems'
require 'gosu'
require 'RMagick'
require 'gosui'

class ExampleWindow < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = 'Gosui Example'
    @cursor = Gosui::Mouse_Pointer.new(self)
    @panel = Gosui::Panel.new(self,100,100,200,200)
    @dialog = Gosui::Dialog.new(self, 300, 300, 400, 50, "This is a dialog")
  end
  
  def draw
    @cursor.draw
    @panel.draw
    @dialog.draw
  end
end

ExampleWindow.new.show