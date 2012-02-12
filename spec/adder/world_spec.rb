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

  it "repositions the spaceship with a velocity of [2,3,3] calculated over 10 sec" do
    spaceship = Spaceship.new
    subject.bodies[:spaceship] = spaceship
    spaceship.velocity = Vector[2,3,3]
    subject.over(10)
    spaceship.position.should == Vector[20,30,30]
  end

  it "repositions the spaceship with an acceleration of -9.8 in the y direction calculated over 3 second" do
    spaceship = Spaceship.new
    spaceship.acceleration = Vector[0, -9.8, 0]
    subject.bodies[:spaceship] = spaceship
    subject.over(1)
    subject.over(2)
    spaceship.position.should == Vector[0,-44.1,0]
  end

  it "rotates the spaceship with an angular aceelration of [3,2,2] over 3 sec" do
    spaceship = Spaceship.new
    spaceship.angular_acceleration = Vector[3,2,2]
    subject.bodies[:spaceship] = spaceship
    subject.over(3)
    spaceship.rotation.should == Vector[13.5, 9, 9]
    spaceship.angular_velocity.should == Vector[9, 6, 6]
  end
end
