class Moon < Adder::Body
  attr_accessor :radius

  def initialize hash = {}
    self.radius = hash[:radius]

    super hash
  end
end
