class Star < Adder::Body
  attr_accessor :radius

  def initialize hash = {}
    self.radius = hash[:radius] || 2e6
    super hash
  end
end
