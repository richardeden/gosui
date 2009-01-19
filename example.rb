require 'rubygems'
require 'gosu'
require 'RMagick'
require 'gosui'

class ExampleWindow < Gosu::Window #possibly create a Gosui window which has a gosui event handler
  attr_accessor :event_handler
  
  def initialize
    super(800, 600, false)
    self.caption = 'Gosui Example'
    @cursor = Gosui::Mouse_Pointer.new(self)
    @event_handler = Gosui::EventHandler::Dispatcher.new(self, @cursor)
    @dialog = Gosui::Dialog.new(self, 300, 100, 200, 50, "This is a dialog")
    @button = Gosui::Button.new(self, 100, 30, 100, 50, "Test Button")
    @dialog.add_component(@button)
  end
  
  def draw
    @cursor.draw
    @dialog.draw
  end
  
  def update
    if button_down? Gosu::Button::MsLeft
      @event_handler.observer_notifier(Gosu::Button::MsLeft)
    end
  end
  
  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
  
  def button_up(id)
    if id == Gosu::Button::MsLeft
      @event_handler.observer_notifier(0)
    end
  end
end


ExampleWindow.new.show