require 'adder/world'
require 'adder/body'

class Spaceship < Adder::Body

end

describe Adder::World do

  subject { Adder::World.new }

  it "repositions the spaceship with an acceleration of [2,5,3] calculated over 2 second" do
    spaceship = Spaceship.new
    subject.bodies[:spaceship] = spaceship
    spaceship.acceleration = Vector[2, 5, 3]
    subject.over(2)
    spaceship.position.should == Vector[4, 10, 6]
  end

end
