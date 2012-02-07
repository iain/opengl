class GridView < View
  def draw!
    @model.data.each do |info|
      drawField(*info)
    end
  end

  def drawField x, y, z, color
    field_size = 0.5
    glColor(*color)
    glBegin(GL_QUADS)
    glVertex(-field_size + x, y, field_size + z)
    glVertex(-field_size + x, y,-field_size + z)
    glVertex( field_size + x, y,-field_size + z)
    glVertex( field_size + x, y, field_size + z)
    glEnd
  end

end

