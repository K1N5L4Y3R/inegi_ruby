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
  
  def test_get_makes_correct_request
    indexes = Inegi::Client.get("/5300000041")
    assert_equal "http://inegifacil.com/rest/indice/5300000041", indexes.request.last_uri.to_s
  end
  
  def test_format_indexes
    hash = {
      "header" => {"INDICADOR" => "1002000001","COBER_GEO" => "00000",
      "FREQ" => "V","DECIMALS" => "0","TOPIC" => "000400010001","NOTE" => "9,49,115,422,425"},
      "indices" => [
        {
          "TIME_PERIOD" => "1910","OBS_VALUE" => "15160369","OBS_STATUS" => "D",
          "OBS_UNIT" => "N\u00famero de personas","OBS_SOURCE" => "538"
        },
        {
          "TIME_PERIOD" => "1921","OBS_VALUE" => "14334780","OBS_STATUS" => "D",
          "OBS_UNIT" => "N\u00famero de personas","OBS_SOURCE" => "538"
        }
      ]
    }
    formatted = Inegi::Client.format_indexes(hash)
    assert_equal 2, formatted[:values].length
    expected_values = [
      {
        period: "1910",
        value: "15160369",
        units: "N\u00famero de personas"
      },
      {
        period: "1921",
        value: "14334780",
        units: "N\u00famero de personas"
      }
    ]
    expected = { indicator: "1002000001", values: expected_values }
    assert_equal expected, formatted
  end
  
  def test_indexes
    indexes = @inegi.indexes "1002000001"
    assert_equal "1002000001", indexes[:indicator]
    assert_equal 13, indexes[:values].length
    assert_equal "1910", indexes[:values].first[:period]
    assert_equal "15160369", indexes[:values].first[:value]
    assert_equal "Número de personas", indexes[:values].first[:units]
  end
  
  def test_nested_indexes
    indexes = @inegi.indexes "1002000001", "21000"
    assert_equal "1002000001", indexes[:indicator]
    assert_equal 13, indexes[:values].length
    assert_equal "1910", indexes[:values].first[:period]
    assert_equal "1101600", indexes[:values].first[:value]
    assert_equal "Número de personas", indexes[:values].first[:units]
  end
end
