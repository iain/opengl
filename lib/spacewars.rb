require 'spacewars/space_wars'
require 'spacewars/block'

$camera = camera = Walker::Camera.new(-5)

block = Block.new
space_wars = SpaceWars.new(camera, block)

window = Walker::Window.new(space_wars)

window.views << Walker::CameraView.new(camera)

window.views << BlockView.new(block)

window.start
