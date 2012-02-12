class Benchmark
  def initialize
    @list = {}
    start
    @results = []
  end

  def start
    @results << @list unless @list.size == 0
    @last_mark_time = Time.now.to_f
  end

  def mark title
    @list[title] = Time.now.to_f - @last_mark_time
    @last_mark_time = Time.now.to_f
  end

  def report
    @list.each do |name, time|
      puts "#{name}:#{time * 1000}"
    end
  end

  def next_value data_set, title
    data_set[data_set.keys[data_set.keys.index(title)+1]]
  end

  def average_value title
    average = 0
    @results.each do |data|
      average += next_value(data,title) - data[title]
    end
    average/@results.length
  end

  def report_average_value title
    puts "Average mark for #{title}: #{average_value(title) * 1000}"
  end
end
