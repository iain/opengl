require 'spacewars/spaceship'

class SpaceWars < Talisman::Controller

  attr_reader :camera, :spaceship

  def initialize(camera, spaceship)
    @camera, @spaceship = camera, spaceship
    @time = time
  end

  on key: "w" do |e|
    spaceship.pitch(-e.duration)
  end

  on key: "s" do |e|
    spaceship.pitch(e.duration)
  end

  on key: "a" do |e|
    spaceship.roll(-e.duration)
  end

  on key: "d" do |e|
    spaceship.roll(e.duration)
  end

  on key: "z" do |e|
    spaceship.yaw(-e.duration)
  end

  on key: "c" do |e|
    spaceship.yaw(e.duration)
  end

  # on key: "x" do
  #   spaceship.reset_rotation
  # end

  on key: '[' do
    spaceship.accelerate
  end

  on key: '\'' do
    spaceship.brake
  end

  on key: "=" do
    camera.zoom_in
  end

  on key: "-" do
    camera.zoom_out
  end

  on key: "h" do
    camera.yaw(-0.01)
  end

  on key: "j" do
    camera.pitch( 0.01)
  end

  on key: "k" do
    camera.pitch(-0.01)
  end

  on key: "l" do
    camera.yaw( 0.01)
  end

  on key: "f" do
    window.enter_full_screen
  end

  on key: "F" do
    window.leave_full_screen
  end

  on key: "t" do
    camera.follow_object = Adder::World.instance.bodies.values[Adder::World.instance.bodies.values.index(camera.follow_object) - 1]
    # p camera.follow_object.texture
  end

  on key: " " do
    spaceship.engage_warp
  end

  on key: "x" do
    spaceship.disengage_warp
  end

  on key: "q" do
    exit
  end

  def on_tick
    Adder::World.instance.over((time - @time))
    spaceship.calculate_warp_speed if spaceship.in_warp
    # p spaceship.velocity

    @time = time
  end

  def time
    Time.now.to_f * Adder::World.instance.time_multiplier
  end

end
