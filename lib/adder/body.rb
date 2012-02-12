require 'matrix'

module Adder
  class Body
    attr_accessor :position, :velocity, :acceleration

    def initialize
      self.position     = Vector[0, 0, 0]
      self.velocity     = Vector[0, 0, 0]
      self.acceleration = Vector[0, 0, 0]
    end

    def calculate_position dt
      self.position += velocity*dt + acceleration * 0.5 * dt**2
    end
  end
end
