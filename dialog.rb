module Gosui
  class Dialog
    
    attr_accessor :dialog_title_box, :dialog_box
    def initialize(window, size_x, size_y, loc_x, loc_y, text)
      @window = window
      @size_x = size_x
      @size_y = size_y
      @loc_x = loc_x
      @loc_y = loc_y
      @text = text
      
      setup_image(window, size_x, size_y)
      
      @font = Gosu::Font.new(@window, Gosu::default_font_name, 12)
    end
    
    def setup_image(window, size_x, size_y)
      dialog_title_img = dialog_box_img = File.expand_path(File.dirname(__FILE__) + '/media/dialog_title_bar.png')
      m_dialog_title_img = Magick::Image.read(dialog_title_img).first
      dialog_title_img_scaled = m_dialog_title_img.scale(size_x, 25)
      @dialog_title_box = Gosu::Image.new(window, dialog_title_img_scaled, true)
      
      dialog_box_img = File.expand_path(File.dirname(__FILE__) + '/media/dialog.png')
      m_dialog_img = Magick::Image.read(dialog_box_img).first
      dialog_img_scaled = m_dialog_img.scale(size_x, size_y)
      @dialog_box = Gosu::Image.new(window, dialog_img_scaled, true)
    end
    
    def draw
      @dialog_title_box.draw(@loc_x, @loc_y, Gosui::ZOrder::Dialog)
      @dialog_box.draw(@loc_x, @loc_y+25, Gosui::ZOrder::Dialog)
      @font.draw("#{@text}",@loc_x + 100, @loc_y + 10, Gosui::ZOrder::Dialog, 1.0, 1.0, 0xffffffff)
    end
  end
end