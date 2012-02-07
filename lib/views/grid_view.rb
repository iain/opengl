class GridView < View

  def initialize *args
    super

    @buffers = nil
  end

  def buffered?
    @buffers.nil?
  end

  def draw!
    set_buffers if buffered?

    @model.data.each do |info|
      glPushMatrix
      show_field(*info)
      glPopMatrix
    end

    drawSky
  end

  def drawSky
    glutSolidSphere(1280/2,36,36)
  end

  def set_buffers
    @colours = glGenBuffers(1)

    #set colour

    colors = [
      0.0,0.9,0.0,
      0.0,0.9,0.0,
      0.0,0.7,0.0,
      0.0,0.5,0.0,
      0.0,0.0,0.0,
      0.0,0.0,0.0,
      0.0,0.0,0.0,
      0.0,0.0,0.0
    ]

    glBindBuffer(GL_ARRAY_BUFFER_ARB, @colours[0])
    glBufferData(GL_ARRAY_BUFFER, 6*8*3, colors.pack("f*"), GL_STREAM_DRAW);


    @buffers = glGenBuffers(1)


    glBindBuffer(GL_ARRAY_BUFFER_ARB, @buffers[0])

    field_size = 10.0

    vertices = [
       -field_size, 3, +field_size,
       -field_size, 3, -field_size,
       +field_size, 3, -field_size,
       +field_size, 3, +field_size,
       -field_size, 0, +field_size,
       +field_size, 0, +field_size,
       +field_size, 0, -field_size,
       -field_size, 0, -field_size
    ].pack("f*")

    glBufferData(GL_ARRAY_BUFFER, 6*8*3, vertices,GL_DYNAMIC_DRAW)
  end

  def show_field x, y, z, color

    #    1-----2
    #   /|    /|
    #  / |   / |
    # 0-----3  |
    # |  7--|- 6
    # | /   | /
    # |/    |/
    # 4-----5


    indices = [
        0, 1, 2, 3,
        4, 7, 6, 5,
        0, 4, 7, 1,
        3, 2, 6, 5,
        7, 6, 2, 1,
        4, 5, 3, 0
      ]
    field_size = 10.0

    x *= 2*field_size
    y -= 20
    z *= 2*field_size

    glTranslate(x,y,z)

    glBindBuffer(GL_ARRAY_BUFFER, @buffers[0])
    glEnableClientState(GL_VERTEX_ARRAY)
    glVertexPointer(3, GL_FLOAT, 0, 0)

    glBindBuffer(GL_ARRAY_BUFFER, @colours[0])
    glEnableClientState(GL_COLOR_ARRAY)
    glColorPointer(3, GL_FLOAT, 0, 0)

    glDrawElements(GL_QUADS, 24, GL_UNSIGNED_BYTE, indices)

    glBindBuffer(GL_ARRAY_BUFFER, 0)

    glDisableClientState(GL_COLOR_ARRAY)
    glDisableClientState(GL_VERTEX_ARRAY)
  end
end

