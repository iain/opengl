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
        [ Random.rand(1.0), Random.rand(1.0), Random.rand(1.0)]
    end
    a = a.flatten
    @bitmap = Image.constitute(@width,@height,"RGB",a)
  end

  def show
    @bitmap.display if @bitmap
    exit
  end

  def save
    @bitmap.write('world.bmp')
  end
end

generator = World.new(128,128)
generator.generate
generator.save

