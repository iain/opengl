class Textures
  include Gl, Glu, Glut

  def initialize
    @textures = []
    @hash     = {}

  end

  def loaded_textures
    @hash.keys
  end

  def find key
    if @hash[key].nil?
      raise "No texture loaded with this name"
    else
      @textures[@hash[key]]
    end
  end

  def load_all
    file_names = Dir["textures/*"].map { |file| file if file.split('.').last == 'bmp' }.compact

    file_names.each_with_index do |f, index|
      @hash[f.split('/')[1][(0..-5)].gsub('.','_').to_sym] = index
    end

    @textures = glGenTextures(file_names.size)

    file_names.size.times do |i|
      image = Magick::Image::read(file_names[i]).first
      load(@textures[i],image.to_blob,image.rows, image.columns)
    end
  end

  def load texture, image_binary, width, height
    glBindTexture(GL_TEXTURE_2D, texture) # Bind The Texture

    glTexEnvf( GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE )

    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );

    #glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
    gluBuild2DMipmaps( GL_TEXTURE_2D, 3, width, height, GL_BGR, GL_UNSIGNED_BYTE, image_binary )
    texture
  end

end
