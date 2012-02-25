Given /^I have the following vertices:$/ do |table|
  @p = Plane.new do |p|
    table.raw.each do |vertex|
      p.vertex(*vertex.collect(&:to_f))
    end
  end
end

When /^I cut with (-{0,1}\d*\.{0,1}\d+) \+ (-{0,1}\d*\.{0,1}\d+)x$/ do |x, y|
  @cut_function = [x.to_f,y.to_f]
end

Then /^the functions should be:$/ do |table|
  functions = @p.vertices.combination(2).map do |vertii|
    @p.create_function(*vertii)
  end

  functions.should == table.raw.map { |t| t.collect(&:to_f) }
end

Then /^I find the following points:$/ do |table|
  points = @p.vertices.combination(2).map do |v|
    @p.find_new_vertex(@cut_function, *v)
  end

  points.compact.should == table.raw.map { |t| t.collect(&:to_f) }
end

Then /^I should have the following vertices to be removed:$/ do |table|
  points = @p.find_to_be_deleted_vertices(@cut_function)
  points.should == table.raw.map { |t| t.collect(&:to_f) }
end

Then /^I should have the following vertices replacing the removed vertex:$/ do |table|
  replacement_vertices = []
  @p.find_replacement_vertices(@cut_function)[2].should == table.raw.map { |t| t.collect(&:to_f) }

end

### ### ### ###

Then /^I should see the following vertices:$/ do |table|
  @p.cut(@cut_function)
  @p.vertices.should == table.raw.map { |t| t.collect(&:to_f) }
end
