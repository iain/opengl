require 'talisman/event'

describe Talisman::Event do

  it "sets the x attribute" do
    expect { subject.register x: 1 }.to change { subject.x }.to 1
  end

  it "sets the y attribute" do
    expect { subject.register y: 2 }.to change { subject.y }.to 2
  end

  it "sets the key attribute" do
    expect { subject.register key: "e" }.to change { subject.key }.to "e"
  end

  it "sets the type attribute" do
    expect { subject.register type: :mouse }.to change { subject.type }.to :mouse
  end

  it "knows the time since the last trigger" do
    clock = stub "Time"
    clock.stub(:now) { Time.at(0) }
    subject = Talisman::Event.new(clock)
    clock.stub(:now) { Time.at(1) }
    subject.trigger
    subject.duration.should be_within(0.1).of(1.0)
  end

  it "tracks the movement of cursor" do
    subject.register x: 1
    subject.register x: 3
    subject.delta(:x).should == 2
  end

  it "handles movement of cursor when only one register happened" do
    subject.register y: 5
    subject.delta(:y).should == 5
  end

end
