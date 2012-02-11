require 'spacewars/spaceship'

class SpaceWars < Talisman::Controller

  attr_reader :camera, :spaceship

  def initialize(camera, spaceship)
    @camera, @spaceship = camera, spaceship
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
    camera.roll(-0.1)
  end

  on "j" do
    camera.pitch( 0.1)
  end

  on "k" do
    camera.pitch(-0.1)
  end

  on "l" do
    camera.roll( 0.1)
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
    spaceship.animate
  end

end
