module Gosui
  class Button
    def initialize(window, size_x, size_y, loc_x, loc_y, text)
      @window = window
      @size_x = size_x
      @size_y = size_y
      @loc_x = loc_x
      @loc_y = loc_y
      @text = text
      @button = setup_image(window, size_x, size_y)
    end
    
    def setup_image(window, size_x, size_y)      
      button_img = File.expand_path(File.dirname(__FILE__) + '/media/button.png')
      m_button_img = Magick::Image.read(button_img).first
      @dialog_box = Gosu::Image.new(window, m_button_img.scale!(size_x, size_y), true)
    end
    
    def draw
      @button.draw(@loc_x, @loc_y+25, Gosui::ZOrder::Button)
      @font.draw("#{@text}",@loc_x - calculate_text_location, @loc_y + 10, Gosui::ZOrder::Button, 1.0, 1.0, 0xffffffff)
    end
    
    def calculate_text_location
      (@font.text_width(@text, 1) - @size_y) / 2
    end
    
  end
end