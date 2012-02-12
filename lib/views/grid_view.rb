class GridView < View

  def initialize *args
    super

    @hash = {}
    @field_size = 5.0
  end

  def buffered?
    @hash.empty?
  end

  def draw!
    set_list if buffered?

    glTranslate(-@field_size * (@model.width/2), 0, -@field_size * (@model.height/2))
    i = 0
    @model.width.times do |height|
      glPushMatrix
      @model.height.times do |width|
        glTranslate(@field_size,0,0)

        show_field(*@model.data[i])
        i += 1
      end
      glPopMatrix
      glTranslate(0,0,@field_size)
    end

    drawSky
  end

  def drawSky
    width = @model.width * @field_size
    depth = @model.height * @field_size
    height = width

    vertices = [
       -width, height, +depth,
       -width, height, -depth,
       +width, height, -depth,
       +width, height, +depth,
       -width, -20, +depth,
       +width, -20, +depth,
       +width, -20, -depth,
       -width, -20, -depth
    ]

    indices = [
        0, 1, 2, 3,
        4, 7, 6, 5,
        0, 4, 7, 1,
        3, 2, 6, 5,
        7, 6, 2, 1,
        4, 5, 3, 0
      ]

    glEnableClientState(GL_VERTEX_ARRAY)

    glVertexPointer(3, GL_FLOAT, 0, vertices)

    glColor(0.3,0.3,0.8)
    glDrawElements(GL_QUADS, 24, GL_UNSIGNED_BYTE, indices)

    glBindBuffer(GL_ARRAY_BUFFER, 0)

    glDisableClientState(GL_VERTEX_ARRAY)
  end

  def set_list
    @hash[:cube] = glGenLists(1)
    glNewList(@hash[:cube], GL_COMPILE)
    glBegin(GL_QUADS)
    drawCube(@field_size/2)
    glEndList
  end

  def show_field x, y, z, color_index
    glColor(*@model.color_list[color_index])
    glCallList(@hash[:cube][0]);
  end
end




