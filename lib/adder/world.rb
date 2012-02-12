module Adder
  class World
    attr_accessor :bodies

    def initialize
      self.bodies = {}
    end

    def over dt
      bodies.each do |name, body|
        body.calculate(dt)
      end
    end

  end
end
