class Camera

  include Rotation

  def initialize(zoom = 0)
    @zoom = zoom
  end

  def zoom_in
    @zoom += 0.1
  end

  def zoom_out
    @zoom -= 0.1
  end

  def roll(r)
    rotation.roll!(r)
  end

  def pitch(r)
    rotation.pitch!(r)
  end

  # Change the matrix to allow for zooming
  def matrix
    rotation.matrix + rotation.translate(0, 0, @zoom)
  end

end
