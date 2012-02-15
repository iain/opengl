class Fuselage < Walker::View

  def draw
    glMultMatrix(@model.matrix)
  end

end
