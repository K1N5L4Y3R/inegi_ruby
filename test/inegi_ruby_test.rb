require 'test_helper'

class InegiRubyTest < TestHelper
  def setup
    @inegi = Inegi::Client.new
  end
end
