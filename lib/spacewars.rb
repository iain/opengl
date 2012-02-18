require 'spacewars/fuselage'
require 'spacewars/celestial_body'
require 'spacewars/celestial_body_view'
require 'spacewars/space_wars'
require 'spacewars/spaceship'

$camera = camera = Walker::Camera.new( -4e6)

sun = CelestialBody.new(
  :mass  => 1.9891e30,
  :radius => 6.995e8,
  :texture => :sunmap
)

earth = CelestialBody.new do |p|
  p.mass             = 5.9736e24
  p.radius           = 6.358e6
  p.texture          = :earthmap
  p.position         = Vector[1.496e11, 0, 0, 0]
  p.velocity         = Vector[0, 0, 29780, 0]
  p.angular_velocity = Vector[0,(2*Math::PI/86400),0, 0]
end

moon  = CelestialBody.new do |m|
  m.mass     = 7.3477e22
  m.radius   = 1.735e6
  m.texture  = :moonmap
  m.position = Vector[1.500e11, 0, 0, 0]
  m.velocity = Vector[0, 0, 30802, 0]
end

mars = CelestialBody.new do |m|
  m.texture  = :marsmap
  m.mass     = 6.419e23
  m.radius   = 3.376e6
  m.position = Vector[2.49e11, 0, 0, 0]
  m.velocity = Vector[0, 0, 24077, 0]
end

jupiter = CelestialBody.new do |j|
  j.texture  = :jupitermap
  j.mass     = 1.899e27
  j.radius   = 7.1e7
  j.position = Vector[7.453e11, 0, 0, 0]
  j.velocity = Vector[0,0,13000, 0]
end

celestial_bodies = {:sun => sun, :earth => earth, :moon => moon, :mars => mars, :jupiter => jupiter}

world = Adder::World.instance
world.gravity = true
world.add_bodies(celestial_bodies)
world.time_multiplier = 86400/24

camera.follow_object = sun


spaceship = Spaceship.new

space_wars = SpaceWars.new(camera, spaceship)

window = Walker::Window.new(space_wars)

window.views << Walker::CameraView.new(camera)
celestial_bodies.each do |key, value|
  window.views << CelestialBodyView.new(value)
end
# window.views << SunView.new(Sun.new)

window.start
