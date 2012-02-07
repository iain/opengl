class Cube

  attr_accessor :world

  def initialize
    @x = 0
    @y = 0
    @w = 1
    @h = 0.66
    @rotation = 45
  end

  def draw
    drawCube
  end

  def drawCube
    glLoadIdentity

    glTranslate(@x, @y, 0)
    glRotate(@rotation,1,1,0)

    glBegin(GL::QUADS)

    #front and back
    glColor(1, 0, 0)
    glVertex( 0.5, 0.5, 0.5)
    glVertex(-0.5, 0.5, 0.5)
    glVertex(-0.5,-0.5, 0.5)
    glVertex( 0.5,-0.5, 0.5)

    glColor(1, 0, 1)
    glVertex( 0.5, 0.5,-0.5)
    glVertex(-0.5, 0.5,-0.5)
    glVertex(-0.5,-0.5,-0.5)
    glVertex( 0.5,-0.5,-0.5)

    #left and right
    glColor(0, 1, 0)
    glVertex( 0.5, 0.5,-0.5)
    glVertex( 0.5, 0.5, 0.5)
    glVertex( 0.5,-0.5, 0.5)
    glVertex( 0.5,-0.5,-0.5)

    glColor(1, 1, 0)
    glVertex(-0.5, 0.5,-0.5)
    glVertex(-0.5, 0.5, 0.5)
    glVertex(-0.5,-0.5, 0.5)
    glVertex(-0.5,-0.5,-0.5)

    #top and bottom

    glColor(0, 0, 1)
    glVertex( 0.5, 0.5, 0.5)
    glVertex(-0.5, 0.5, 0.5)
    glVertex(-0.5, 0.5,-0.5)
    glVertex( 0.5, 0.5,-0.5)

    glColor(0, 1, 1)
    glVertex( 0.5,-0.5, 0.5)
    glVertex(-0.5,-0.5, 0.5)
    glVertex(-0.5,-0.5,-0.5)
    glVertex( 0.5,-0.5,-0.5)


    glEnd

    @rotation += 0.01
    #@square_x += (0.01 / 2 / Math::PI)
    #@square_y += (0.01 / 2 / Math::PI)
  end
end
