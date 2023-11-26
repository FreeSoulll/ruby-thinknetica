require_relative './modules/instance_counter'
require_relative './modules/validatable'
require_relative './custom_errors'
require_relative './modules/validation'
require_relative './modules/accessors'

class Test
  include Validation
  extend Accessors

  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :d, :d.class
end

test = Test.new
test.a = 5
puts test.a
test.a = 50
puts test.a
puts test.a_history

test.b = 8
puts test.b
test.b = 80
puts test.b
test.b_history
puts test.b_history

test.d = :ff
puts test.d
