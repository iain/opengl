class Spaceship < Adder::Body

  attr_accessor :in_warp

  TURN_SPEED = 1.0

  include Walker::Rotation

  def roll(duration)
    rotation.roll!(TURN_SPEED * duration) unless in_warp
  end

  def yaw(duration)
    rotation.yaw!(TURN_SPEED * duration) unless in_warp
  end

  def reset_rotation
    rotation.reset
  end

  def pitch(duration)
    rotation.pitch!(TURN_SPEED * duration * 0.5) unless in_warp
  end

  def accelerate
    self.velocity -= Vector[0,0, 1e4, 0] unless in_warp
  end

  def brake
    self.velocity += Vector[0,0, 1e4, 0] unless in_warp
  end

  def disengage_warp
    unless stopping?
      @stop = true

      @time_since_engage = Time.now.to_f
    end
  end

  def engage_warp
    @stop = false

    self.in_warp = true

    @time_since_engage = Time.now.to_f
  end

  def calculate_warp_speed
    t    = Time.now.to_f - @time_since_engage
    k    = 0.5 #1/versnelling
    vmax = 3e8 * 20  #max warp speed

    if stopping?
      self.velocity = Vector[0, 0, -(velocity[2].abs * Math.exp(-t * k)), 0]
      out_of_warp if velocity[2].abs < 1000
    else
      self.velocity = Vector[0, 0, -(vmax - vmax * Math.exp(-t * k)), 0]
    end
  end

  def out_of_warp
    self.in_warp = false
  end

  def stopping?
    @stop
  end


end
