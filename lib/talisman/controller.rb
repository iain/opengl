require 'talisman/event'

module Talisman
  class Controller

    # TODO deprecate the use of anything other than hash as parameter
    def self.on(id_or_key, &action)
      id = id_or_key.is_a?(Hash) ? id_or_key : { key: id_or_key }
      callbacks[id] = action
    end

    def self.callbacks
      @callbacks ||= {}
    end

    def key_press(key, x, y)
      events[key: key].trigger(type: :key, key: key, x: x, y: y)
    end
    alias_method :special_key_press, :key_press

    def key_up(key, x, y)
      events.delete(key: key)
    end
    alias_method :special_key_up, :key_up

    def callbacks
      self.class.callbacks
    end

    def on_tick
      # no op
    end

    def events
      @events ||= Hash.new { |h,k| h[k] = Event.new }
    end

    attr_accessor :window

    def fire_events
      call_callbacks
      on_tick
    end

    def call_callbacks
      events.each do |id, event|
        callback = callbacks[id]
        instance_exec(event, &callback) if callback
      end
    end

  end
end
