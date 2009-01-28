module Gosui
	class TextInput
		attr_accessor :loc_x, :loc_y, :size_x, :size_y, :clicked
		def initialize(window, size_x, loc_x, loc_y, text)
			@window = window
			@size_x = size_x
			@size_y = 30
			@loc_x = loc_x
			@loc_y = loc_y
			@text = text
			@text_input = setup_image(window, size_x, size_y)
			@font = Gosu::Font.new(@window, Gosu::default_font_name, 12)
			window.event_handler.register_component(self,  Gosu::Button::MsLeft)
			window.event_handler.register_component(self,  0)
		end
		
		def setup_image(window, size_x, size_y)      
			text_input_img = File.expand_path(File.dirname(__FILE__) + '/media/text_input.png')
			m_text_input_img = Magick::Image.read(text_input_img).first
			@text_input = Gosu::Image.new(window, m_text_input_img.scale!(size_x, size_y), true)
		end
		
		def draw
			@text_input.draw(@loc_x, @loc_y, Gosui::ZOrder::TextInput)
			@font.draw("#{@text}",@loc_x - calculate_text_location, @loc_y + 5, Gosui::ZOrder::TextInput, 1.0, 1.0, 0xffffffff)
		end
    
		def calculate_text_location
			(@font.text_width(@text, 1))
		end
		
		def input_event(event_type)
			if event_type == Gosu::Button::MsLeft
				puts "blah"
			elsif event_type == 0
				@clicked = false
		end
    end
	end
end