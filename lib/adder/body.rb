require 'matrix'

module Adder
  class Body
    attr_accessor :position, :velocity, :acceleration, :rotation, :angular_velocity, :angular_acceleration

    def initialize
      self.position             = Vector[0, 0, 0]
      self.velocity             = Vector[0, 0, 0]
      self.acceleration         = Vector[0, 0, 0]

      self.rotation             = Vector[0, 0, 0]
      self.angular_velocity     = Vector[0, 0, 0]
      self.angular_acceleration = Vector[0, 0, 0]
    end

    def calculate(dt)
      calculate_position(dt)
      calculate_velocity(dt)

      calculate_rotation(dt)
      calculate_angular_velocity(dt)
    end

    def calculate_position(dt)
      self.position += velocity * dt + acceleration * 0.5 * dt**2
    end

    def calculate_velocity(dt)
      self.velocity += acceleration * dt
    end


    def calculate_rotation(dt)
      self.rotation += angular_velocity * dt + angular_acceleration * 0.5 * dt**2
    end

    def calculate_angular_velocity(dt)
      self.angular_velocity += angular_acceleration * dt
    end

  end
end
