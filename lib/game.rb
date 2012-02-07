require 'set'
require 'window'
require 'cube'

Window.draw do

  title "OpenGL in Ruby"

  width 600
  height 600

  left 10
  top 10

  add :cube, Cube.new

  on "f" do
    enter_fullscreen
  end

  on "F" do
    exit_fullscreen
  end

  on "q" do
    exit
  end

end
