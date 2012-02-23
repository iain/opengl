require 'matrix'
require 'mathn'

module Clynish
  class Draw

    attr_accessor :draw_type

    def initialize draw_type
      self.draw_type = draw_type
      self.vertices = []

      # glBegin(draw_type)
      yield self if block_given?
      # glEnd
    end



  end

  class Plane

    attr_accessor :vertices

    def initialize
      self.vertices = []
      yield self if block_given?
    end

    def vertex(x, y)
      self.vertices << [x,y]
    end

    def cut *cut_vertex
      vertices.each_with_index do |vertex, index|
        vertex.size.times do |t|
          self.vertices[index][t] = cut_vertex[t] if (vertex[t] > cut_vertex[t])
        end
      end
      vertices
    end
  end

end

include Clynish

plane = Plane.new do |p|
  p.vertex(0,0)
  p.vertex(2,0)
  p.vertex(2,2)
end

plane.cut(1,1)
p plane.vertices
