class MoonView < Walker::View
  def draw
    glTranslate(*@model.position.to_a)
    # puts "acceleration #{@model.acceleration} with speed #{@model.velocity}"
    puts @model.distance_of(Adder::World.instance.bodies[:earth]).magnitude

    texture = Walker::Textures.instance.find(:moonmap,2)

    quadro = gluNewQuadric();
    gluQuadricNormals(quadro, GLU_SMOOTH);
    gluQuadricTexture(quadro, GL_TRUE);
    glEnable(GL_TEXTURE_2D);

    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, texture);
    gluSphere(quadro, @model.radius, 72, 72);
    glDisable(GL_TEXTURE_2D);
    gluDeleteQuadric(quadro);
  end
end
