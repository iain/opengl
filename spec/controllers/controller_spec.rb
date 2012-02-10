require 'controllers/controller'

class TestController < Controller

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

describe Controller do

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

end
