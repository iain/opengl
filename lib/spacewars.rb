require 'spacewars/fuselage'
require 'spacewars/planet'
require 'spacewars/planet_view'
require 'spacewars/moon'
require 'spacewars/moon_view'
require 'spacewars/space_wars'
require 'spacewars/spaceship'

camera = Walker::Camera.new( -40)
camera.pitch(Math::PI/2)

earth = Planet.new(:mass => 5.9736e24, :radius => 6.358e6)
moon  = Moon.new(:mass => 7.3477e22, :radius => 1.735e6, :position => Vector[4e8,0,0], :velocity => Vector[0, 1022, 0])

world = Adder::World.instance

world.gravity = true
world.add_bodies(:earth => earth, :moon => moon)


spaceship = Spaceship.new

space_wars = SpaceWars.new(camera, spaceship)

window = Walker::Window.new(space_wars)

window.views << Walker::CameraView.new(camera)
window.views << PlanetView.new(earth)
window.views << MoonView.new(moon)
window.views << Fuselage.new(spaceship)
# window.views << SunView.new(Sun.new)

window.start
