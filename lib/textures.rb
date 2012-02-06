class Texture
  include Gl, Glu, Glut

  def initialize
    @textures = [nil]
  end

  def find path
    @textures[0] || load(path)
  end

  def load path
    #file = File.open("textures/#{path}","b")
    data = File.open("textures/#{path}", "rb") {|io| io.read }

    width = height = 512

    #data = ([0]*4*width*height).pack("f*")
    @textures = glGenTextures(1) # Create 1 Texture

    glBindTexture(GL_TEXTURE_2D, @textures[0]) # Bind The Texture

    glTexEnvf( GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE )
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR )
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR )
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT )
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT )
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);

    @textures[0]
  end

end
