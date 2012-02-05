require 'matrix'

class Rotator

  M = Matrix
  include Math

  attr_accessor :matrix

  def initialize
    self.matrix = yaw(0) * roll(0) * pitch(0)
  end

  def roll(r)
    M[
      [  cos(r), 0, sin(r), 0 ],
      [       0, 1,      0, 0 ],
      [ -sin(r), 0, cos(r), 0 ],
      [  0,      0,      0, 1 ]
    ]
  end

  def roll!(r)
    self.matrix *= roll(r)
  end

  def yaw(r)
    M[
      [  cos(r), -sin(r), 0, 0 ],
      [  sin(r),  cos(r), 0, 0 ],
      [       0,       0, 1, 0 ],
      [  0,      0,       0, 1 ]
    ]
  end

  def yaw!(r)
    self.matrix *= yaw(r)
  end

  def pitch(r)
    M[
      [  1,      0,       0, 0 ],
      [  0, cos(r), -sin(r), 0 ],
      [  0, sin(r),  cos(r), 0 ],
      [  0,      0,       0, 1 ]
    ]
  end

  def pitch!(r)
    self.matrix *= pitch(r)
  end

  def translate(x, y, z)
    M[
      [ 0, 0, 0, 0],
      [ 0, 0, 0, 0],
      [ 0, 0, 0, 0],
      [ x, y, z, 0]
    ]
  end

  def translate!(x, y, z)
    self.matrix += translate(x, y, z)
  end

end
