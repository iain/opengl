RSpec::Matchers.define :be_matrix_like do |*expected|

  match do |actual|
    expected_matrix = Matrix[*expected]
    @diffs = []
    actual.each_with_index do |value, row, col|
      e = expected_matrix[row, col]
      if (value - e).abs > delta
        @diffs << [ row, col ]
      end
    end
    @diffs.empty?
  end

  def delta
    0.01
  end

  failure_message_for_should do |actual|
    msg = "Difference found in matrices at coordinates: #{@diffs.map(&:inspect).join(', ')}"
    msg += "\n\nExpected:\n#{pretty_matrix(Matrix[*expected])}\n"
    msg += "\n\nActual:\n#{pretty_matrix(actual)}\n"
  end

  failure_message_for_should_not do |actual|
    msg = "Expected the following matrices to be different:\n#{pretty_matrix(actual)}"
  end

  def pretty_matrix(matrix)
    matrix.to_a.map.with_index { |row, row_index|
      "[ #{format_row(row, row_index)} ] #{row_indicator(row_index)}"
    }.join("\n")
  end

  def format_row(row, row_index)
    row.map.with_index { |val, col_index|
      val >= 0 ? (" %.3f" % val) : ("%.3f" % val)
    }.join(", ")
  end

  def row_indicator(row_index)
    if @diffs.find { |(row, col)| row == row_index }
      " <- "
    else
      ""
    end
  end

end
