def drawCube size
  #glBegin(GL_QUADS) #this is required before the call thus making the choice for wired or solid
  #possible
  #front
  glTexCoord( 0.0, 1.0); glVertex(-size,-size, size)
  glTexCoord( 1.0, 1.0); glVertex(-size, size, size)
  glTexCoord( 1.0, 0.0); glVertex( size, size, size)
  glTexCoord( 0.0, 0.0); glVertex( size,-size, size)

  #back
  glTexCoord( 0.0, 1.0); glVertex(-size,-size,-size)
  glTexCoord( 1.0, 1.0); glVertex(-size, size,-size)
  glTexCoord( 1.0, 0.0); glVertex( size, size,-size)
  glTexCoord( 0.0, 0.0); glVertex( size,-size,-size)

  #top
  glTexCoord( 0.0, 0.0); glVertex(-size, size,-size)
  glTexCoord( 0.0, 1.0); glVertex(-size, size, size)
  glTexCoord( 1.0, 1.0); glVertex( size, size, size)
  glTexCoord( 1.0, 0.0); glVertex( size, size,-size)

  #bottom
  glTexCoord( 0.0, 0.0); glVertex(-size,-size,-size)
  glTexCoord( 0.0, 1.0); glVertex(-size,-size, size)
  glTexCoord( 1.0, 1.0); glVertex( size,-size, size)
  glTexCoord( 1.0, 0.0); glVertex( size,-size,-size)

  #left
  glTexCoord( 0.0, 0.0); glVertex(-size,-size,-size)
  glTexCoord( 0.0, 1.0); glVertex(-size,-size, size)
  glTexCoord( 1.0, 1.0); glVertex(-size, size, size)
  glTexCoord( 1.0, 0.0); glVertex(-size, size,-size)

  #right
  glTexCoord( 0.0, 0.0); glVertex( size,-size,-size)
  glTexCoord( 0.0, 1.0); glVertex( size,-size, size)
  glTexCoord( 1.0, 1.0); glVertex( size, size, size)
  glTexCoord( 1.0, 0.0); glVertex( size, size,-size)

  glEnd
end
