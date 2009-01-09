module Gosui
  module EventHandler
    class Dispatcher
      attr_accessor :observers
      def initialize
        @observers = []
      end
      
      def register_component(ui_component, event)
        observer = Observer.new(ui_component, event)
        @observers << observer
      end
      
      def deregister_observer(ui_component)
      end
      
      def observer_notifier(event_type)
        @observers.each do |observer|
          if observer.event == event_type
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
      
      def update
      end
      
    end
    
  end
end