class Spaceship

  include Rotation

  attr_accessor :name, :commands

  def initialize
    send_to_server!
    self.commands = []
  end

  def animate
    rotation.yaw!(0.01)
    rotation.pitch!(-0.01)
    rotation.roll!(0.02)
  end

  def roll_left
    rotation.roll!(-0.05)
  end

  def roll_right
    rotation.roll!(0.05)
  end

  def yaw_left
    rotation.yaw!(-0.01)
  end

  def yaw_right
    rotation.yaw!(0.01)
  end

  def reset_rotation
    rotation.reset
  end

  def pitch_down
    rotation.pitch!( 0.01)
  end

  def pitch_up
    rotation.pitch!(-0.01)
  end

  def accelerate
    rotation.translate!(0,0,-0.1)

    send_to_server!
  end

  def brake
    rotation.translate!(0,0, 0.1)
  end

  def send_to_server!
    $connection.send_matrix rotation.matrix
  end

  def set_matrix matrix
    rotation.set(matrix)
  end

  def activate_callback key
    spaceship = self
    SpaceWars.callbacks[key].call
  end

end
