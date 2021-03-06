module Gosui
  class Dialog
    
    attr_accessor :dialog_title_box, :dialog_box, :size_x, :size_y, :loc_x, :loc_y, :clicked, :mouse_x, :mouse_y, :components
    attr_accessor :component_offset_x, :component_offset_y, :new_x, :new_y

    def initialize(window, size_x, size_y, loc_x, loc_y, text)
      @window = window
      @size_x = size_x
      @size_y = size_y
      @loc_x = loc_x
      @loc_y = loc_y
      @new_x = @loc_x
      @new_y = @loc_y
      @text = text
      @clicked = false
      @components = []
      window.event_handler.register_component(self,  Gosu::Button::MsLeft)
      window.event_handler.register_component(self,  0)
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
      if clicked == true
        @loc_x = (@window.mouse_x - @drag_offset_x)
        @loc_y = (@window.mouse_y - @drag_offset_y)
        @dialog_title_box.draw(@loc_x, @loc_y, Gosui::ZOrder::Dialog)
        @dialog_box.draw(@loc_x, @loc_y + 25, Gosui::ZOrder::Dialog)
        @font.draw("#{@text}",@loc_x - calculate_text_location, @loc_y + 10, Gosui::ZOrder::Dialog, 1.0, 1.0, 0xffffffff)
        @components.each do |component|
          if @new_x != @loc_x || @new_y != @loc_y
            x = @new_x - @loc_x
            y = @new_y - @loc_y
            update_component_location(component,x,y)
          end 
          component.draw
        end
        @new_x = @loc_x
        @new_y = @loc_y
      else  
        @dialog_title_box.draw(@loc_x, @loc_y, Gosui::ZOrder::Dialog)
        @dialog_box.draw(@loc_x, @loc_y+25, Gosui::ZOrder::Dialog)
        @font.draw("#{@text}",@loc_x - calculate_text_location, @loc_y + 10, Gosui::ZOrder::Dialog, 1.0, 1.0, 0xffffffff)
        @components.each do |component|
          component.draw
        end
      end
      
    end
    
    def input_event(event_type)
      if event_type == Gosu::Button::MsLeft
        if !@clicked
          @drag_offset_x = @window.mouse_x - @loc_x
          @drag_offset_y = @window.mouse_y - @loc_y
        end
        @clicked = true
      elsif event_type == 0
        @clicked = false
      end
    end
    
    def add_component(ui_component)
      ui_component.loc_x = ui_component.loc_x + @loc_x
      ui_component.loc_y = ui_component.loc_y + @loc_y
      @components << ui_component
    end
    
    def update_component_location(ui_component,x,y)
      ui_component.loc_x = ui_component.loc_x - x
      ui_component.loc_y = ui_component.loc_y - y
    end
    
    def calculate_text_location
      (@font.text_width(@text, 1) - @size_x) / 2
    end
  end
end