require 'matrix'
require 'pry'
require 'mathn'

module Adder
  class Body
    attr_accessor :mass, :position, :velocity, :acceleration, :rotation, :angular_velocity, :angular_acceleration

    def initialize args = {}
      self.mass                 = args[:mass]                 || 10
      self.position             = args[:position]             || Vector[0, 0, 0]
      self.velocity             = args[:velocity]             || Vector[0, 0, 0]
      self.acceleration         = args[:acceleration]         || Vector[0, 0, 0]

      self.rotation             = args[:rotation]             || Vector[0, 0, 0]
      self.angular_velocity     = args[:angular_velocity]     || Vector[0, 0, 0]
      self.angular_acceleration = args[:angular_acceleration] || Vector[0, 0, 0]
    end

    def calculate(dt)
      calculate_position(dt)
      calculate_velocity(dt)

      calculate_rotation(dt)
      calculate_angular_velocity(dt)

      calculate_gravity(dt) if World.instance.gravity
    end

    def calculate_position(dt)
      self.position += velocity * dt + acceleration * 0.5 * dt**2
    end

    def calculate_velocity(dt)
      self.velocity += acceleration * dt
    end

    def calculate_gravity(dt)
      World.instance.bodies.each do |name, body|
        if distance_of(body) != Vector[0,0,0] && (body.mass + mass) > 0
          self.acceleration += Vector[gravitational_force(body,0),gravitational_force(body,1),gravitational_force(body,2)]
        end
        # self.acceleration += (body.position[1] - position[1])**2 * (6.67e-11 * body.mass * mass)**-1
      end
    end

    def gravitational_force(body,direction)
      distance = distance_of(body)[direction]
      if distance == 0
        0
      else
        distance**-2 * 6.67e-11 * body.mass * mass
      end
    end


    def calculate_rotation(dt)
      self.rotation += angular_velocity * dt + angular_acceleration * 0.5 * dt**2
    end

    def calculate_angular_velocity(dt)
      self.angular_velocity += angular_acceleration * dt
    end

    def distance_of(other)
      other.position - position
    end
  end
end

class Vector
  def **(num)
    Vector[self[0]**num,self[1]**num,self[2]**num]
  end
end
