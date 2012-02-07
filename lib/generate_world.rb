require 'rubygems'
require 'rmagick'
class World
  include Magick

  def initialize width, height
    @width = width
    @height = height
  end

  def generate
    a = (@width * @height).times.map do
        [ 0.0, Random.rand(0.8) + 0.2, 0.0,Random.rand(1.0)]
    end
    a = a.flatten
    @bitmap = Image.constitute(@width,@height,"RGBA",a)
  end

  def show
    @bitmap.display if @bitmap
    exit
  end

  def save
    @bitmap.write('world.bmp')
  end
end

generator = World.new(64,64)
generator.generate
generator.save

