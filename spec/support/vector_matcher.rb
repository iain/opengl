RSpec::Matchers.define :be_vector_like do |expected|
  diffable

  match do |actual|
    @diffs = []
    actual.each_with_index do |value, index|
      e = expected[index]
      if e.nil?
        @diffs << index
      else
        if (value - e).abs > delta
          @diffs << index
        end
      end
    end
    @diffs.empty?
  end

  def delta
    0.01
  end
end
