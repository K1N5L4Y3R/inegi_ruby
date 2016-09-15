require 'test_helper'

class InegiRubyTest < TestHelper
  def setup
    @inegi = Inegi::Client.new
  end
  
  def test_general
    assert_instance_of Inegi::Client, @inegi
  end
  
  def test_validate_index
    assert Inegi::Client.validate_index("5300000041")
    assert Inegi::Client.validate_index("1002000065")
    assert Inegi::Client.validate_index("3108001003")
    assert_raises (ArgumentError) { Inegi::Client.validate_index("53000000412") }
    assert_raises (ArgumentError) { Inegi::Client.validate_index("") }
    assert_raises (ArgumentError) { Inegi::Client.validate_index("a") }
  end
  
  def test_aggregate_returns_aggregated_indexes
    skip "not implemented"
    aggregate = @inegi.aggregate("5300000041")
    assert_equal expected, actual, "expected `actual` to be `expected`"
  end
end
