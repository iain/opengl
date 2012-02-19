class Spaceship < Adder::Body

  include Walker::Rotation

  def roll_left
    rotation.roll!(-0.1)
  end

  def roll_right
    rotation.roll!(0.1)
  end

  def yaw_left
    rotation.yaw!(-0.1)
  end

  def yaw_right
    rotation.yaw!(0.1)
  end

  def reset_rotation
    rotation.reset
  end

  def pitch_down
    rotation.pitch!( 0.1)
  end

  def pitch_up
    rotation.pitch!(-0.1)
  end

  def accelerate
    rotation.translate!(0,0,0.1)
  end

  def brake
    rotation.translate!(0,0,-0.1)
  end

end
