class Grid
  include Magick

  attr_accessor :data, :color_list

  def initialize path
    @path = path
    @width      = 0
    @height     = 0
    self.color_list = []
    self.data   = []

    load_world
  end

  def width
    @width
  end

  def height
    @height
  end

  def set_new_color r, g ,b
    if color_index = color_list.index([r,g,b])
    else
      color_index = color_list.size
      self.color_list << [r,g,b]
    end
    color_index
  end

  def load_world
    world = ImageList.new(@path)

    @width  = world.rows
    @height = world.columns

    data = world.view(0,0,@height,@width)
    @height.times do |width|
      @width.times do |height|
        color_index = set_new_color(((data[width][height].red)/65535),((data[width][height].green)/65535),((data[width][height].blue)/65535))
        self.data << [
          width - @width/2,
          (data[width][height].opacity/20000.round) + 1,
          height - @height/2,
          color_index
        ]
      end
    end
  end
end
