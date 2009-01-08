module Gosui
  module EventHandler
    class Subject
      attr_accessor observers
      def initialize
        @observers = []
      end
      
      def register_observer(ui_component, event)
        observer = Observer.new
        observer.ui_component = ui_component
        observer.event = event
        @observers << observer
      end
      
      def observer_notifier(event_type)
        @obervers.each do |observer|
          if observer.event_type == event_type
            observer.event_handler(event_type)
        end
      end
      
    end
    class Observer
      def initialize(ui_component, event)
        @ui_component = ui_component
        @event = event
      end
      def update
      end
    end
  end
end