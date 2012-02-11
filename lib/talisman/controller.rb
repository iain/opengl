require 'set'

module Talisman
  class Controller

    def self.on(key, &action)
      callbacks[key] = action
    end

    def self.callbacks
      @callbacks ||= {}
    end

    def key_press(key, x, y)
      keys << key
    end

    def key_up(key, x, y)
      keys.delete(key)
    end

    def special_key_press(key, x, y)
      keys << key
    end

    def special_key_up(key, x, y)
      keys.delete(key)
    end

    def keys
      @keys ||= Set.new
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
      keys.each do |key|
        callback = callbacks[key]
        instance_eval(&callback) if callback
      end
    end

  end
end
