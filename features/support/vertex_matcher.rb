RSpec::Matchers.define :be_vertex_map_like do |expected|
  match do |actual|
    expected = expected.map { |t| t.collect(&:to_f) }
    @diffs = []

    actual.each_with_index do |vertex, index|
      vertex.each_with_index do |value, i|
        if (value - expected[index][i]).abs > delta
          @diffs << [index,i]
        end
      end
    end
    @diffs.empty?
  end

  def delta
    0.01
  end
end
