require 'walker/rotation'
require 'support/matrix_matcher'

class RotatableObject
  include Walker::Rotation
end

describe Walker::Rotation do

  describe "with a class that includes Rotation" do

    subject { RotatableObject.new }

    it "exposes the rotation" do
      subject.rotation.should be_a Walker::Rotation::Rotator
    end

    it "exposes the matrix (needed so much for OpenGL, it is public)" do
      subject.matrix.object_id.should == subject.rotation.matrix.object_id
    end

  end


  describe Walker::Rotation::Rotator do

    subject { Walker::Rotation::Rotator.new }

    context "at the start" do

      it "starts unrotated and centered (a plain identity matrix)" do
        subject.matrix.should == Matrix.identity(4)
      end

    end

    describe "#yaw!" do

      it "rotates along the x axis" do
        subject.yaw! Math::PI / 2
        subject.matrix.should be_matrix_like(
          [ 0, -1, 0, 0 ],
          [ 1,  0, 0, 0 ],
          [ 0,  0, 1, 0 ],
          [ 0,  0, 0, 1 ]
        )
      end

    end

    describe "#pitch!" do

      it "rotates along the y axis" do
        subject.pitch! Math::PI / 2
        subject.matrix.should be_matrix_like(
          [ 1, 0,  0, 0 ],
          [ 0, 0, -1, 0 ],
          [ 0, 1,  0, 0 ],
          [ 0, 0,  0, 1 ]
        )
      end

    end

    describe "#roll!" do

      it "rotates along the z axis" do
        subject.roll! Math::PI / 2
        subject.matrix.should be_matrix_like(
          [  0, 0, 1, 0 ],
          [  0, 1, 0, 0 ],
          [ -1, 0, 0, 0 ],
          [  0, 0, 0, 1 ]
        )
      end

    end

    describe "#translate!" do

      it "moves along x axis" do
        subject.translate!(10, 0, 0)
        subject.matrix.should be_matrix_like(
          [  1, 0, 0, 0 ],
          [  0, 1, 0, 0 ],
          [  0, 0, 1, 0 ],
          [ 10, 0, 0, 1 ]
        )
      end

      it "moves along y axis" do
        subject.translate!(0, 2, 0)
        subject.matrix.should be_matrix_like(
          [  1, 0, 0, 0 ],
          [  0, 1, 0, 0 ],
          [  0, 0, 1, 0 ],
          [  0, 2, 0, 1 ]
        )
      end

      it "moves along z axis" do
        subject.translate!(0, 0, 4)
        subject.matrix.should be_matrix_like(
          [  1, 0, 0, 0 ],
          [  0, 1, 0, 0 ],
          [  0, 0, 1, 0 ],
          [  0, 0, 4, 1 ]
        )
      end

      it "moves the object, keeping its rotation in mind" do
        subject.roll! Math::PI / 2
        subject.translate! 1, 0, 0
        subject.matrix.should be_matrix_like(
          [  0, 0, 1, 0 ],
          [  0, 1, 0, 0 ],
          [ -1, 0, 0, 0 ],
          [  0, 0, 1, 1 ]
        )
      end

      it "rotates after it moved" do
        subject.translate! 1, 0, 0
        subject.roll! Math::PI / 2
        subject.matrix.should be_matrix_like(
          [  0, 0, 1, 0 ],
          [  0, 1, 0, 0 ],
          [ -1, 0, 0, 0 ],
          [  1, 0, 0, 1 ]
        )
      end

    end

  end

end
