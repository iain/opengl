class PlanetView < Walker::View
  def draw
    texture = Walker::Textures.instance.find(:earthmap,2)

    glTranslate(*@model.position.to_a)
    glRotate(@model.rotation.magnitude,*@model.rotation.directions.to_a)
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
