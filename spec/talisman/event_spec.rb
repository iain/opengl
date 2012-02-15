require 'talisman/event'

describe Talisman::Event do

  it "sets the x attribute" do
    expect { subject.trigger x: 1 }.to change { subject.x }.to 1
  end

  it "sets the y attribute" do
    expect { subject.trigger y: 2 }.to change { subject.y }.to 2
  end

  it "sets the key attribute" do
    expect { subject.trigger key: "e" }.to change { subject.key }.to "e"
  end

  it "sets the type attribute" do
    expect { subject.trigger type: :mouse }.to change { subject.type }.to :mouse
  end

end
