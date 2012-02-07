class Grid
  include Magick

  attr_accessor :data

  def initialize path
    @path = path
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
    world = ImageList.new(@path)

    @width  = world.rows
    @height = world.columns

    data = world.view(0,0,@height,@width)
    @height.times do |width|
      @width.times do |height|
        self.data << [
          width - @width/2,
          (data[width][height].opacity/6553.5.round) + 1,
          height - @height/2,
          [
            ((data[width][height].red)/65535),
            ((data[width][height].green)/65535),
            ((data[width][height].blue)/65535),
            1.0
          ]
        ]
      end
    end
  end
end
