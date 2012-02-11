module Talisman
  class Controller
    Event = Struct.new(:key, :x, :y)

    def self.on(key, &action)
      callbacks[key] = action
    end

    def self.callbacks
      @callbacks ||= {}
    end

    def key_press(key, x, y)
      keys[key] = Event.new(key, x, y)
    end
    alias_method :special_key_press, :key_press

    def key_up(key, x, y)
      keys.delete(key)
    end
    alias_method :special_key_up, :key_up

    def keys
      @keys ||= {}
    end

    def callbacks
      self.class.callbacks
    end

    def on_tick
      # no op
    end

    attr_accessor :window

    def fire_events
      call_callbacks
      on_tick
    end

    def call_callbacks
      keys.each do |key, event|
        callback = callbacks[key]
        instance_exec(event, &callback) if callback
      end
    end

  end
end
