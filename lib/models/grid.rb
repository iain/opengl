class Grid
  include Magick

  attr_accessor :data

  def initialize
    @width      = 0
    @height     = 0
    self.data   = []

    load_world
  end

  def width
    @width
  end

  def height
    @height
  end

  def load_world
    world = ImageList.new('world.png')

    @width  = world.rows
    @height = world.columns

    data = world.view(0,0,@height,@width)
    @height.times do |width|
      @width.times do |height|
        self.data << [
          width - 64,
          height - 64,
          [
            ((data[width][height].red)/65535),
            ((data[width][height].green)/65535),
            ((data[width][height].blue)/65535)
          ]
        ]
      end
    end
  end
end
