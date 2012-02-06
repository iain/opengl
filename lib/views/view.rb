class View
  include Gl, Glu, Glut

  def initialize(model)
    @model = model
  end

  def draw!
    glPushMatrix
    draw
    glPopMatrix
  end

  def draw
    raise NotImplentedError,
      "View objects must define a draw method"
  end

end
