class Fuselage < View

  def draw
    glMultMatrix(@model.rotation)

    texture = $window.textures.find(:wooden_box)
    glEnable( GL_TEXTURE_2D )
    glBindTexture( GL_TEXTURE_2D, texture )
    glBegin(GL_QUADS)
    drawCube(1)
  end

end
