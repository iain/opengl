class GridView < View
  def draw!
    @model.data.each do |info|
      drawField(*info)
    end
  end

  def drawField x, y, z, color
    field_size = 10.0

    x *= 2*field_size
    z *= 2*field_size

    glColor(*color)
    glBegin(GL_QUADS)
    #
    #    1-----2
    #   /|    /|
    #  / |   / |
    # 0-----3  |
    # |  7--|- 6
    # | /   | /
    # |/    |/
    # 4-----5
    #
    #top 0 1 2 3
    glVertex(-field_size + x, y, field_size + z)
    glVertex(-field_size + x, y,-field_size + z)
    glVertex( field_size + x, y,-field_size + z)
    glVertex( field_size + x, y, field_size + z)

    #side 4 0 1 7
    glVertex( field_size + x, 0, field_size + z)
    glVertex( field_size + x, y, field_size + z)
    glVertex( field_size + x, y,-field_size + z)
    glVertex( field_size + x, 0,-field_size + z)

    #side 1 2 6 7
    glVertex( field_size + x, y,-field_size + z)
    glVertex(-field_size + x, y,-field_size + z)
    glVertex(-field_size + x, 0,-field_size + z)
    glVertex( field_size + x, 0,-field_size + z)

    #side 2 3 5 6
    glVertex(-field_size + x, 0, field_size + z)
    glVertex(-field_size + x, y, field_size + z)
    glVertex(-field_size + x, y,-field_size + z)
    glVertex(-field_size + x, 0,-field_size + z)

    #side 0 3 4 5
    glVertex( field_size + x, y, field_size + z)
    glVertex(-field_size + x, y, field_size + z)
    glVertex(-field_size + x, 0, field_size + z)
    glVertex( field_size + x, 0, field_size + z)
    glEnd
  end

end

