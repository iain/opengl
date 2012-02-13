require 'singleton'

module Adder
  class World
    include Singleton

    attr_accessor :bodies, :gravity

    def add_bodies hash
      hash.each do |name, body|
        self.bodies[name] = body
      end
    end

    def initialize
      self.bodies = {}
      self.gravity = false
    end

    def over dt
      bodies.each do |name, body|
        body.calculate(dt)
      end
    end

  end
end
