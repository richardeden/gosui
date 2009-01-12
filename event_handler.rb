module Gosui
  module EventHandler
    class Dispatcher
      attr_accessor :observers
      attr_reader :window, :mouse
      def initialize(window, mouse)
        @observers = []
        @window = window
        @mouse = mouse
      end
      
      def register_component(ui_component, event)
        observer = Observer.new(ui_component, event)
        @observers << observer
      end
      
      def deregister_observer(ui_component)
      end
      
      def observer_notifier(event_type)
        @observers.each do |observer|
          if observer.event == event_type && observer.within_bounds?(@mouse.get_x, @mouse.get_y)
            observer.event_handler(event_type)
          end
        end
      end
      
    end
    
    class Observer
      attr_accessor :ui_component, :event
 
      def initialize(ui_component, event)
        @ui_component = ui_component
        @event = event
      end
      
      def event_handler(event_type)
        @ui_component.input_event(event_type)
      end
        
      def within_bounds?(mouse_x, mouse_y)
        if (@ui_component.loc_x..@ui_component.loc_x + @ui_component.size_y) === mouse_x.to_i && (@ui_component.loc_y..@ui_component.loc_y + @ui_component.size_x) === mouse_y.to_i
          return true
  	    end
  	    false
      end
    end
    
  end
end