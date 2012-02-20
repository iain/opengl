class Hud

end

class HudView < Walker::View
  def draw!
    glDepthFunc(GL_LESS);

    glLoadIdentity
    glColor(0.5,0.5,0.5)
    glBegin(GL_QUADS)
    glVertex(0, 1)
    glVertex(1, 1)
    glVertex(1, 0)
    glVertex(0, 0)
    glEnd

    glDepthMask(GL_TRUE);

  end
end
