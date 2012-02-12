module Adder
  class World
    attr_accessor :bodies

    def initialize
      self.bodies = {}
    end

    def over dt
      bodies.each do |name, body|
        body.calculate_position(dt)
        body.calculate_velocity(dt)

        body.calculate_rotation(dt)
        body.calculate_angular_velocity(dt)
      end
    end

  end
end
