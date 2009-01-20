module Gosui
  class Checkbox
    attr_accessor :loc_x, :loc_y, :size_x, :size_y, :checked, :checkbox_img_on, :checkbox_img_off
    def initialize(window, size_x, size_y, loc_x, loc_y, text)
      @window = window
      @size_x = size_x
      @size_y = size_y
      @loc_x = loc_x
      @loc_y = loc_y
      @checked = false
      @text = text
      @checkbox = setup_image(window, size_x, size_y)
      @font = Gosu::Font.new(@window, Gosu::default_font_name, 12)
      window.event_handler.register_component(self,  Gosu::Button::MsLeft)
      window.event_handler.register_component(self,  0)
    end
    
    def setup_image(window, size_x, size_y)      
      checkbox_img = File.expand_path(File.dirname(__FILE__) + '/media/checkbox.png')
      m_checkbox_off_img = Magick::Image.read(checkbox_img).first
      m_checkbox_off_img.crop!(0,0,12,12)
      @checkbox_img_off = Gosu::Image.new(window, m_checkbox_off_img.scale!(size_x, size_y), true)
      
      m_checkbox_on_img = Magick::Image.read(checkbox_img).first
      m_checkbox_on_img.crop!(13,0,12,12)
      @checkbox_img_on = Gosu::Image.new(window, m_checkbox_on_img.scale!(size_x, size_y), true)
    end
    
    def draw
      !@checked ? @checkbox_img_off.draw(@loc_x, @loc_y, Gosui::ZOrder::Checkbox) : @checkbox_img_on.draw(@loc_x, @loc_y, Gosui::ZOrder::Checkbox)
      @font.draw("#{@text}",@loc_x - calculate_text_location, @loc_y, Gosui::ZOrder::Checkbox, 1.0, 1.0, 0xffffffff)
    end
    
    def calculate_text_location
      (@font.text_width(@text, 1))
    end
    
    def checked?
      @checked
    end
    
    def input_event(event_type)
      if event_type == Gosu::Button::MsLeft
        @checked = !@checked
      end
    end
  end
end