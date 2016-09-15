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
    assert !Inegi::Client.validate_index("53000000412")
    assert !Inegi::Client.validate_index("")
    assert !Inegi::Client.validate_index("a")
  end
end
