RSpec::Matchers.define :be_matrix_like do |*expected|

  match do |actual|
    expected_matrix = Matrix[*expected]
    @diffs = []
    actual.each_with_index do |value, row, col|
      e = expected_matrix[row, col]
      if e.nil?
        @diffs << [ row, col ]
      else
        if (value - e).abs > delta
          @diffs << [ row, col ]
        end
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
    }.join("\n") + "\n" + column_indicator(matrix)
  end

  def format_row(row, row_index)
    row.map.with_index { |val, col_index| format_value(val) }.join(", ")
  end

  def format_value(val)
    if val.is_a?(Numeric)
      (val >= 0 ? (" %.3f" % val) : ("%.3f" % val)).rjust(7)
    else
      val.inspect.rjust(7)
    end
  end

  def row_indicator(row_index)
    if @diffs.find { |(row, col)| row == row_index }
      " <- "
    else
      ""
    end
  end

  def column_indicator(matrix)
    "  " + matrix.row(0).to_a.map.with_index { |val, index|
      if @diffs.find { |(row, col)| col == index }
        "^   ".rjust(7)
      else
        " " *  7
      end
    }.join('  ')
  end

end
