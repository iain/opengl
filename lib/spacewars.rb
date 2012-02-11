require 'spacewars/fuselage'
require 'spacewars/sky'
require 'spacewars/sky_view'
require 'spacewars/space_wars'
require 'spacewars/spaceship'

camera = Walker::Camera.new( -40)
camera.pitch(Math::PI/2)

spaceship = Spaceship.new
space_wars = SpaceWars.new(camera, spaceship)

window = Walker::Window.new(space_wars)

window.views << Walker::CameraView.new(camera)
window.views << Fuselage.new(spaceship)
window.views << SkyView.new(Sky.new)
# window.views << SunView.new(Sun.new)

window.start
