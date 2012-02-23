class SpaceWars < Talisman::Controller

  attr_reader :camera, :block

  def initialize(camera, block)
    @camera = camera
    @block  = block

    @time = time
    @dt   = 0
  end

  on key: " " do
    block.plane.cut(0)
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

  on key: "q" do
    exit
  end

  def on_tick
  end

  def time
    Time.now.to_f * Adder::World.instance.time_multiplier
  end

end
