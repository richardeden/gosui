module Gosui
	class Mouse_Pointer
		def initialize(window)
			img = File.expand_path(File.dirname(__FILE__) + '/media/cursor.bmp')
			@pointer = Gosu::Image.new(window, img, true)
			@window = window
		end
	
		def draw
			@pointer.draw(@window.mouse_x, @window.mouse_y, Gosui::ZOrder::Mouse)
		end
		
		def get_x
		  @window.mouse_x
	  end
	  
	  def get_y
	    @window.mouse_y
    end
	end
end