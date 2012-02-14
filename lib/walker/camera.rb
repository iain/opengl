module Walker
  class Camera

    include Rotation

    def initialize(zoom = 1)
      @zoom = zoom

      # roll(-Math::PI/2)
      # yaw(-Math::PI)
    end

    def zoom_in
      @zoom *= 0.9
    end

    def zoom_out
      @zoom *= 1.1
    end

    def roll(r)
      self.rotation.matrix *= rotation.roll(r)
    end

    def yaw(r)
      self.rotation.matrix *= rotation.yaw(r)
    end

    def pitch(r)
      self.rotation.matrix *= rotation.pitch(r)
    end

    # Change the matrix to allow for zooming
    def matrix
      rotation.matrix + rotation.translate(0, 0, @zoom)
    end

  end
end
