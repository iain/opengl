require 'matrix'
require 'mathn'

module Clynish
  class Draw

    attr_accessor :draw_type, :vertices

    def initialize draw_type
      self.draw_type = draw_type
      self.vertices = []

      # glBegin(draw_type)
      yield self if block_given?
      # glEnd
    end

    def vertex(x, y)
      self.vertices << [x,y]
    end

    def circle(radius, z_slices, x = 0, y = 0, z = 0)

      # Draw.new(GL_TRIANGLE_FAN) do |draw|
      #   draw.circle(5, 36) do |x ,y|
      #     draw.vertex(x, y, 0)
      #   end
      # end

      vertex(x, y, z) if draw_type == GL_TRIANGLE_FAN

      step = 2 * Math::PI / z_slices

      (z_slices + 1).times do |i|
        deg = i * step
        x = Math.cos(deg) * radius
        y = Math.sin(deg) * radius

        yield x, y
      end
    end

    def full_plane_mesh(x = 5, y = 5)
      mesh_density = 5 # per coordinate
      mesh = Mesh.new(x,y, mesh_density)
      (x*y*mesh_density).times do |i|
        # x1 = x.to_f/mesh_density
        # y1 = y.to_f/mesh_density
        mesh[i] = nil
      end

      mesh
    end

    def in_plane?(*coords)
      mesh_density = 5 # per coordinate
      plane_type = 3 #triangles

      vertices.combination(plane_type).each do |plane|
        previous_vertex = nil

        plane.each do |vertex|
          if previous_vertex
            dx = (vertex[0] - previous_vertex[0])
            dy = (vertex[1] - previous_vertex[1])
            if dx == 0
              slope = 99
            else
              slope = dy / dx)
            end
            # p [previous_vertex, vertex, "#{previous_vertex[1]} + #{slope}*x"]
          end
          previous_vertex = vertex
        end
      end
    end
  end

  class Mesh < Array
    attr_accessor :width, :height, :density

    def initialize(width, height, mesh_density)
      self.width    = width
      self.height   = height
      self.density  = mesh_density
    end

    def set(value,x,y)
      self[y * width * density + x * density] = value
    end

    def read(x,y)
      self[y * width * density + x * density]
    end

    def pretty
      (height * density).times do |x|
        r = []
        (width * density).times.map do |y|
          r << read(x,y)
        end
        p r
      end
    end
  end
end

include Clynish

x_plane = Draw.new(:quads) do |draw|
  draw.vertex(0,0)
  draw.vertex(2,0)
  draw.vertex(2,2)
end
mesh = x_plane.full_plane_mesh

mesh.pretty

# p mesh.read(2.5,2.5)
# mesh.set(nil,2.5,2.5)
# p mesh.read(2.5,2.5)

x_plane.in_plane?(1,1)
