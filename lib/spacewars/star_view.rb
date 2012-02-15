class StarView < Walker::View
  def draw
    texture = Walker::Textures.instance.find(:sunmap,2)

    glMultMatrix(@model.matrix)

    glRotate(90,-1,0,0) #fix sideway texture..

    quadro = gluNewQuadric();
    gluQuadricNormals(quadro, GLU_SMOOTH);
    gluQuadricTexture(quadro, GL_TRUE);
    glEnable(GL_TEXTURE_2D);

    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, texture);
    gluSphere(quadro, @model.radius, 360, 360);
    glDisable(GL_TEXTURE_2D);
    gluDeleteQuadric(quadro);
  end
end