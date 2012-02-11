module Walker
  class CameraView < View

    def draw!
      glMultMatrix(@model.matrix)
    end

  end
end
