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

    @model.data.size.times do |i|
      show_field(i)
    end
  end

  def set_buffers
    @colours = glGenBuffers(@model.data.size)

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


    @buffers = glGenBuffers(@model.data.size)

    #set position
    @model.data.each_with_index do |info, index|
      x, y, z, color = info

      glBindBuffer(GL_ARRAY_BUFFER_ARB, @buffers[index])

      field_size = 10.0

      x *= 2*field_size
      z *= 2*field_size

      vertices = [
         x - field_size, y, z + field_size,
         x - field_size, y, z - field_size,
         x + field_size, y, z - field_size,
         x + field_size, y, z + field_size,
         x - field_size, 0, z + field_size,
         x + field_size, 0, z + field_size,
         x + field_size, 0, z - field_size,
         x - field_size, 0, z - field_size
      ].pack("f*")

      glBufferData(GL_ARRAY_BUFFER, 6*8*3, vertices,GL_DYNAMIC_DRAW)

    end
  end

  def show_field id

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

    glBindBuffer(GL_ARRAY_BUFFER, @buffers[id])
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

