require 'adder/world'
require 'adder/body'
require 'support/vector_matcher'

class Spaceship < Adder::Body
end

class Planet < Adder::Body
end

class Moon < Adder::Body
end

describe Adder::World do

  subject { Adder::World.instance }

  before(:each) do
    subject.bodies = {}
    subject.gravity = false
  end

  it "repositions the spaceship with an acceleration of [2,5,3] calculated over 2 second" do
    spaceship = Spaceship.new
    subject.bodies[:spaceship] = spaceship
    spaceship.acceleration = Vector[2, 5, 3]
    subject.over(2)
    spaceship.matrix.position_vector.should == Vector[4, 10, 6]
  end

  it "repositions the spaceship with a velocity of [2,3,3] calculated over 10 sec" do
    spaceship = Spaceship.new
    subject.bodies[:spaceship] = spaceship
    spaceship.velocity = Vector[2,3,3]
    subject.over(10)
    spaceship.matrix.position_vector.should == Vector[20,30,30]
  end

  it "repositions the spaceship with an acceleration of -9.8 in the y direction calculated over 3 second" do
    spaceship = Spaceship.new
    spaceship.acceleration = Vector[0, -9.8, 0]
    subject.bodies[:spaceship] = spaceship
    subject.over(1)
    subject.over(2)
    spaceship.matrix.position_vector.should be_vector_like Vector[0,-44.1,0]
  end

  it "rotates the spaceship with an angular acceleration of [3,2,2] over 3 sec" do
    spaceship = Spaceship.new
    spaceship.angular_acceleration = Vector[3,2,2]
    subject.bodies[:spaceship] = spaceship
    subject.over(3)
    spaceship.matrix.should be_matrix_like(
        [   0.83,  -0.54,   0.10,   0 ],
        [  -0.37,  -0.40,   0.83,   0 ],
        [  -0.41,  -0.73,  -0.54,   0 ],
        [   0.00,   0.00,   0.00,   1 ]
      )
    spaceship.angular_velocity.should == Vector[9, 6, 6]
  end

  it "calculates the distance between objects" do
    earth = Planet.new(:position => Vector[0,0,0])
    venus = Planet.new(:position => Vector[5,5,5])

    subject.bodies[:earth] = earth
    subject.bodies[:venus] = venus

    earth.distance_of(venus).should == Vector[5,5,5]
  end

  it "assigns the gravitational pull off the earth on me" do
    subject.gravity = true

    earth = Planet.new(:mass => 5e24)
    me    = Spaceship.new(:mass => 90, :position => Vector[0, 5.83358e6, 0])

    subject.bodies[:earth] = earth
    subject.bodies[:me]    = me

    me.distance_of(earth).should be_vector_like( Vector[0, -5.83358e6, 0])

    subject.over(0)

    me.acceleration.should be_vector_like(Vector[0,-9.8, 0])
  end

  it "should assign the gravitational pull off the earth on the moon so that it makes a full rotation in 27 days" do
    subject.gravity = true

    earth = Planet.new(:mass => 5e24)
    moon  = Moon.new(:mass => 7.3477e22,:position => Vector[4e8,0,0], :velocity => Vector[0, 0, 1022])

    subject.add_bodies(:earth => earth, :moon => moon)
    subject.over(0)

    moon.acceleration.should be_vector_like(Vector[-0.008, 0, 0])
    moon.velocity.should be_vector_like(Vector[0, 0, 1022])

    old_position_moon = moon.matrix.position_vector
    subject.over(2.361e6)

    moon.velocity[1].should be_within(1022).of(10)

  end

end
