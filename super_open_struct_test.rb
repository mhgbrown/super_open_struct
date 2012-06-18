require 'test/unit'
require 'super_open_struct'

# this is a stupid little test, just to make sure
# that it's essentially doing what I want.
class EachWithProgressTest < Test::Unit::TestCase
  def setup
    @struct = SuperOpenStruct.new
  end

  def test_method_creation
    @struct.foo do |a, b|
      a ** b
    end

    assert_equal(@struct.foo(2, 3), 8)
  end

end