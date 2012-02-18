module Walker
  class CameraView < View

    def draw!
      # glMultMatrix(@model.matrix)
      glMultMatrix(Matrix.identity(4))
    end

  end
end
