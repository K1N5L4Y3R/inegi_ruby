require 'test_helper'

class InegiRubyTest < TestHelper
  def setup
    @inegi = Inegi::Client.new
  end
  
  def test_base_url
    assert_equal "http://inegifacil.com/rest/indice", Inegi::Client::BASE_URL
  end
end
