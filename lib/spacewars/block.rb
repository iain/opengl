class Block < Adder::Body
  include Clynish

  attr_accessor :plane

  def initialize
    self.plane = Plane.new do |p|
      p.vertex( 0 ,  1,   0)
      p.vertex( 1 ,  0,   1)
      p.vertex(-1 ,  0,   1)
      p.vertex(-1 ,  0,  -1)
      p.vertex( 1 ,  0,  -1)
      p.vertex( 1 ,  0,   1)
    end
  end

end

class BlockView < Walker::View
  include Clynish

  def draw
    mult_matrix(@model.matrix)
    Draw.new(GL_TRIANGLE_FAN) do |d|
      @model.plane.vertices.each do |vertex|
        d.color(0,1,0)
        d.vertex(*vertex)
      end
    end
  end

end
