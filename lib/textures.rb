class Textures
  include Gl, Glu, Glut

  def add textures_hash
    @hash = textures_hash
  end

  def find key
    @textures[@hash.keys.find_index(key)]
  end

  def load_all
    @textures = glGenTextures(@hash.size)

    @hash.each_with_index do |values,index|
      load(@textures[index],*values[1])
    end
  end


  def load texture, path, width, height
    glBindTexture(GL_TEXTURE_2D, texture) # Bind The Texture

    glTexEnvf( GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE )

    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );

    data = File.open("textures/#{path}","rb") { |io| io.read }

    #glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
    gluBuild2DMipmaps( GL_TEXTURE_2D, 3, width, height, GL_BGR, GL_UNSIGNED_BYTE, data )
    texture
  end

end
