module Gosui
  class Panel
    def initialize(window, size_x, size_y, loc_x, loc_y)
      @window = window
      @size_x = size_x
      @size_y = size_y
      @loc_x = loc_x
      @loc_y = loc_y
    end
    
    def draw
       @window.draw_quad(@loc_x-50, @loc_y-50, 0xff800000, @loc_x+50, @loc_y-50, 0xff800000, @loc_x-50, @loc_y+50, 0xff800000, @loc_x+50, @loc_y+50, 0xff800000, 0)
    end
  end
end