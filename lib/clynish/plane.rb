module Clynish
  class Plane

    attr_accessor :vertices

    def initialize
      self.vertices = []
      yield self if block_given?
    end

    def vertex(x, y, z = 0)
      self.vertices << [x,y, z]
    end

    def cut(function)
      find_replacement_vertices(function).each_with_index do |new_vertices, index|
        next if new_vertices.nil?

        to_be_deleted = vertices[index]

        new_vertices.each do |vertex|
          vertices.insert(index, vertex)
        end

        vertices.delete(to_be_deleted)
      end

    end

    def find_replacement_vertices(cut_function)
      replacement_vertices = []

      vertices.combination(2).each do |vertii|
        new_vertex = find_new_vertex(cut_function, *vertii)
        if new_vertex
          if to_be_deleted_vertex?(cut_function, vertii[0])
            replacement_vertex = vertii[0]
          else
            replacement_vertex = vertii[1]
          end

          (replacement_vertices[vertices.index(replacement_vertex)] ||= []) << new_vertex
        end
      end

      replacement_vertices
    end

    def find_new_vertex(cut_function, *vertii)
      vertices_function = create_function(*vertii)

      x = cross_function(cut_function, vertices_function)
      if x.finite?
        [x, cut_function[0] + cut_function[1] * x, 0]
      else
        nil
      end
    end

    def find_to_be_deleted_vertices(cut_function)
      to_be_deleted = []
      vertices.each do |vertex|
        to_be_deleted << vertex if to_be_deleted_vertex?(cut_function, vertex)
      end

      to_be_deleted
    end

    def to_be_deleted_vertex?(cut_function, vertex)
      calculate(*cut_function, vertex[0]) > vertex[1] # a + b * x > y
    end

    def cross_function(function_1, function_2)
      (function_1[0] - function_2[0]) / (function_2[1] - function_1[1])
    end

    def create_function(vertex_1, vertex_2)
      dx = vertex_2[0] - vertex_1[0]
      dy = vertex_2[1] - vertex_1[1]

      [vertex_1[1] - vertex_1[0] * (dy / dx), (dy / dx),0]
    end

    def calculate(y0,y,x)
      y0 + y * x
    end

  end
end
