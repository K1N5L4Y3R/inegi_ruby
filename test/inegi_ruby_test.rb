require 'test_helper'

class InegiRubyTest < TestHelper
  def setup
    @inegi = Inegi::Client.new
  end
  
  def test_general
    assert_instance_of Inegi::Client, @inegi
  end
  
  def test_validate_indicator
    assert Inegi::Client.validate_indicator("5300000041")
    assert Inegi::Client.validate_indicator("1002000065")
    assert Inegi::Client.validate_indicator("3108001003")
    assert_raises (ArgumentError) { Inegi::Client.validate_indicator("53000000412") }
    assert_raises (ArgumentError) { Inegi::Client.validate_indicator("") }
    assert_raises (ArgumentError) { Inegi::Client.validate_indicator("a") }
  end
  
  def test_indexes_makes_correct_request
    indexes = @inegi.indexes("5300000041")
    assert_equal "http://inegifacil.com/rest/indice/5300000041", indexes.request.last_uri.to_s
  end
end
