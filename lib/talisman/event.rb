module Talisman
  class Event

    attr_reader :duration, :clock

    def initialize(clock = Time)
      @clock = clock
      @attributes = {}
      @duration = 0
      @trigger_time = clock.now
    end

    def register(attrs)
      @previous_attributes = @attributes
      @attributes = attrs
    end

    def x
      @attributes[:x]
    end

    def y
      @attributes[:y]
    end

    def key
      @attributes[:key]
    end

    def type
      @attributes[:type]
    end

    def trigger
      now = clock.now
      @trigger_time, @duration = now, now - @trigger_time
    end

    def delta(field)
      @attributes[field].to_i - @previous_attributes[field].to_i
    end

  end
end
