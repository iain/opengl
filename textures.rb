require 'rmagick'

class Textures

  def find_in_directory
    file_names = Dir["textures/*"]
    texture_names = file_names.map { |f| f.split('/')[1] }

    image = Magick::Image::read(file_names[0]).first

    @textures = glGenTextures(file_names.size)

    file_names.size.times do |i|
      load(file_names[i],texture_names[i],image.rows, image.columns)
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

a =Textures.new
a.find_in_directory
