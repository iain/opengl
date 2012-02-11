class Fuselage < View

  def draw
    glMultMatrix(@model.matrix)

    texture = $window.textures.find(:neptunemap)

    quadro = gluNewQuadric();
    gluQuadricNormals(quadro, GLU_SMOOTH);
    gluQuadricTexture(quadro, GL_TRUE);
    glEnable(GL_TEXTURE_2D);

    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, texture);
    gluSphere(quadro, 10, 72, 72);
    glDisable(GL_TEXTURE_2D);
    gluDeleteQuadric(quadro);
  end

end
