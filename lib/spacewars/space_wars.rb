require 'spacewars/spaceship'

class SpaceWars < Talisman::Controller

  attr_reader :camera, :spaceship

  def initialize(camera, spaceship)
    @camera, @spaceship = camera, spaceship
    @time = time
  end

  on "w" do
    spaceship.pitch_down
  end

  on "s" do
    spaceship.pitch_up
  end

  on "a" do
    spaceship.roll_left
  end

  on "d" do
    spaceship.roll_right
  end

  on "z" do
    spaceship.yaw_left
  end

  on "c" do
    spaceship.yaw_right
  end

  on "x" do
    spaceship.reset_rotation
  end

  on '[' do
    spaceship.accelerate
  end

  on '\'' do
    spaceship.brake
  end

  on "=" do
    camera.zoom_in
  end

  on "-" do
    camera.zoom_out
  end

  on "h" do
    camera.yaw(-0.1)
  end

  on "j" do
    camera.pitch( 0.1)
  end

  on "k" do
    camera.pitch(-0.1)
  end

  on "l" do
    camera.yaw( 0.1)
  end

  on "f" do
    window.enter_full_screen
  end

  on "F" do
    window.leave_full_screen
  end

  on "q" do
    exit
  end

  def on_tick
    Adder::World.instance.over((time - @time))
    @time = time

    spaceship.animate
  end

  def time
    Time.now.to_f * 50000
  end

end
