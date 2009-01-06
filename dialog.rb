module Gosui
  class Dialog
    def initialize(window, size_x, size_y, loc_x, loc_y, text)
      @window = window
      @size_x = size_x
      @size_y = size_y
      @loc_x = loc_x
      @loc_y = loc_y
      @text = text
      img = File.expand_path(File.dirname(__FILE__) + '/media/dialog.png')
      dialog_img = Magick::Image.read(img).first
      dialog_img_scaled = dialog_img.scale(size_x, size_y)
      @dialog_box = Gosu::Image.new(window, dialog_img_scaled, true)
      @font = Gosu::Font.new(@window, Gosu::default_font_name, 20)
    end
    
    def draw
      @dialog_box.draw(@loc_x, @loc_y, Gosui::ZOrder::Dialog)
      @font.draw("#{@text}",@loc_x + 30, @loc_y, Gosui::ZOrder::Dialog, 1.0, 1.0, 0xffffff00)
    end
  end
end