require 'spacewars/fuselage'
require 'spacewars/planet'
require 'spacewars/planet_view'
require 'spacewars/moon'
require 'spacewars/moon_view'
require 'spacewars/star'
require 'spacewars/star_view'
require 'spacewars/space_wars'
require 'spacewars/spaceship'

camera = Walker::Camera.new( -4e6)

sun = Star.new(
  :mass  => 1.9891e30,
  :radius => 6.995e8
)

earth = Planet.new(
  :mass             => 5.9736e24,
  :radius           => 6.358e6,
  :texture          => :earthmap,
  :position         => Vector[1.496e11, 0, 0],
  :velocity         => Vector[0, 0, 29780],
  :angular_velocity => Vector[0,(2*Math::PI/86400),0]
)

moon  = Moon.new(
  :mass     => 7.3477e22,
  :radius   => 1.735e6,
  :position => Vector[1.500e11, 0, 0],
  :velocity => Vector[0, 0, 30802]
)

mars = Planet.new(
  :texture  => :marsmap,
  :mass     => 6.419e23,
  :radius   => 3.376e6,
  :position => Vector[2.49e11, 0, 0],
  :velocity => Vector[0, 0, 24077]
)

jupiter = Planet.new(
  :texture  => :jupitermap,
  :mass     => 1.899e27,
  :radius   => 7.1e7,
  :position => Vector[7.453e11, 0, 0],
  :velocity => Vector[0,0,13000]
)

world = Adder::World.instance
world.gravity = true
world.add_bodies(:sun => sun, :earth => earth, :moon => moon, :mars => mars, :jupiter => jupiter)
world.time_multiplier = 86400/24

camera.follow_object = sun


spaceship = Spaceship.new

space_wars = SpaceWars.new(camera, spaceship)

window = Walker::Window.new(space_wars)

window.views << Walker::CameraView.new(camera)
window.views << StarView.new(sun)
window.views << PlanetView.new(earth)
window.views << PlanetView.new(mars)
window.views << PlanetView.new(jupiter)
window.views << MoonView.new(moon)
window.views << Fuselage.new(spaceship)
# window.views << SunView.new(Sun.new)

window.start
