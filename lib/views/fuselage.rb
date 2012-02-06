class Fuselage < View

  def draw
    glMultMatrix(@model.matrix)

    glColor(1, 0, 0)
    glutSolidCube 0.5
  end

end
