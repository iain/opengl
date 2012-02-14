require 'matrix'
require 'mathn'
require 'walker'

module Adder
  class Body
    attr_accessor :mass, :velocity, :acceleration, :angular_velocity, :angular_acceleration

    include Walker::Rotation

    GRAVITATION = 6.67384e-11 #N(m/kg)^2

    def initialize args = {}
      rotation.translate!(*args[:position]) if args[:position]

      self.mass                 = args[:mass]                 || 10
      self.velocity             = args[:velocity]             || Vector[0, 0, 0]
      self.acceleration         = args[:acceleration]         || Vector[0, 0, 0]

      self.angular_velocity     = args[:angular_velocity]     || Vector[0, 0, 0]
      self.angular_acceleration = args[:angular_acceleration] || Vector[0, 0, 0]
    end

    def calculate(dt)
      rotation.translate!(*calculate_position(dt))

      calculate_gravity(dt) if World.instance.gravity

      calculate_velocity(dt)

      to_be_rotated = calculate_rotation(dt)

      rotation.rotate(to_be_rotated.magnitude, *to_be_rotated.directions)

      calculate_angular_velocity(dt)
    end

    def calculate_position(dt)
      velocity * dt + acceleration * 0.5 * dt**2
    end

    def calculate_velocity(dt)
      self.velocity += acceleration * dt
    end

    def calculate_gravity(dt)
      self.acceleration = Vector[0, 0, 0]
      World.instance.bodies.each do |name, body|
        self.acceleration += (gravitational_force(body) * (1/mass)) unless body == self
      end
    end

    def gravitational_force(body)
      distance = distance_of(body)

      if distance.magnitude == 0
        Vector[0, 0, 0]
      else
        distance.directions * ((GRAVITATION * body.mass * mass)/(distance.magnitude**2))
      end
    end


    def calculate_rotation(dt)
      angular_velocity * dt + angular_acceleration * 0.5 * dt**2
    end

    def calculate_angular_velocity(dt)
      self.angular_velocity += angular_acceleration * dt
    end

    def distance_of(other)
      (other.matrix.position_vector - matrix.position_vector)
    end
  end
end

class Vector
  def **(num)
    Vector[
      self[0] > 0 ? self[0]**num : 0,
      self[1] > 0 ? self[1]**num : 0,
      self[2] > 0 ? self[2]**num : 0
    ]
  end

  def abs
    Vector[
      self[0].abs,
      self[1].abs,
      self[2].abs
    ]
  end

  def directions
    self == Vector[0, 0, 0] ? self : self * (1/(self.magnitude).abs)
  end
end

class Matrix
  def position_vector
    Vector[
      self[3,0],
      self[3,1],
      self[3,2]
      ]
  end
end
