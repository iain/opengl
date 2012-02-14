require 'walker/rotation'
require 'walker/camera'
require 'support/matrix_matcher'

describe Walker::Camera do

  it "can zoom in" do
    subject.zoom_in
    subject.matrix.should be_matrix_like(
      [ 1, 0,   0, 0 ],
      [ 0, 1,   0, 0 ],
      [ 0, 0,   1, 0 ],
      [ 0, 0, 0.9, 1 ]
    )
  end

  it "can zoom out" do
    subject.zoom_out
    subject.matrix.should be_matrix_like(
      [ 1, 0,    0, 0 ],
      [ 0, 1,    0, 0 ],
      [ 0, 0,    1, 0 ],
      [ 0, 0,  1.1, 1 ]
    )
  end

  it "can zoom out, after rotating" do
    subject.zoom_out
    subject.roll Math::PI / 2
    subject.matrix.should be_matrix_like(
      [  0,-1,    0, 0 ],
      [  1, 0,    0, 0 ],
      [  0, 0,    1, 0 ],
      [  0, 0,  1.1, 1 ]
    )
  end

  it "can zoom in, after rotating" do
    subject.zoom_in
    subject.roll Math::PI / 2
    subject.matrix.should be_matrix_like(
      [  0,-1,    0, 0 ],
      [  1, 0,    0, 0 ],
      [  0, 0,    1, 0 ],
      [  0, 0, 0.9, 1 ]
    )
  end

end
