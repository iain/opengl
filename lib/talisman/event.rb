module Talisman
  class Event

    def initialize
      @attributes = {}
    end

    def trigger(attrs)
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

  end
end
