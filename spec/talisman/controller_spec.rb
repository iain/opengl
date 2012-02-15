require 'talisman/controller'

class TestController < Talisman::Controller

  attr_reader :key_pressed, :ticked

  def initialize
    @key_pressed = Hash.new(0)
    @ticked = 0
  end

  on "w" do
    key_pressed["w"] += 1
  end

  on "a" do
    key_pressed["a"] += 1
 end

  def on_tick
    @ticked += 1
  end

end

class WithEvents < Talisman::Controller

  attr_reader :recorded_events

  def initialize
    @recorded_events = {}
  end

  on "e" do |event|
    @recorded_events["e"] = event
  end

end

describe Talisman::Controller do

  subject { TestController.new }

  it "buffers key down" do
    subject.key_press "w", 0, 0
    expect {
      2.times { subject.fire_events }
    }.to change {
      subject.key_pressed["w"]
    }.to(2)
  end

  it "handles key up events" do
    subject.key_press "w", 0, 0
    subject.fire_events
    subject.key_up "w", 0, 0
    subject.fire_events
    subject.key_pressed["w"].should == 1
  end

  it "ignores multiple key presses" do
    2.times { subject.key_press "w", 0, 0 }
    subject.fire_events
    subject.key_pressed["w"].should == 1
  end

  it "combines multiple keys" do
    subject.key_press "a", 0, 0
    subject.key_press "w", 0, 0

    subject.key_pressed["a"].should == 0
    subject.key_pressed["w"].should == 0

    subject.fire_events

    subject.key_pressed["a"].should == 1
    subject.key_pressed["w"].should == 1
  end

  it "provides a hook for animation" do
    expect {
      subject.fire_events
    }.to change {
      subject.ticked
    }.to(1)
  end

  it "gets events" do
    x, y = stub, stub
    subject = WithEvents.new
    subject.key_press "e", x, y
    subject.fire_events
    event = subject.recorded_events["e"]
    event.x.should == x
    event.y.should == y
    event.key.should == "e"
    event.type.should == :key
  end

end
