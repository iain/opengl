module Clynish
  class Plane

    attr_accessor :vertices

    def initialize
      self.vertices = []
      yield self if block_given?
    end

    def vertex(x, y, z)
      self.vertices << [x,y, z]
    end

    def cut *cut_vertex
      vertices.each_with_index do |vertex, index|
        cut_vertex.size.times do |t|
          self.vertices[index][t] = cut_vertex[t] if (vertex[t] > cut_vertex[t])
        end
        p [vertex, cut_vertex]
      end
      vertices
    end

    def draw
      Draw.new(GL_TRIANGLES) do |d|
        self.vertices.each do |vertex|
          d.vertex(*vertex)
        end
      end
    end

  end
end
