require "inegi_ruby/version"
require "httparty"

module Inegi
  class Client
    include HTTParty
    
    base_uri "http://inegifacil.com/rest/indice"
    
    ##
    # Validates that an indicator adheres to INEGI's format
    # It looks like indicators have a format of 10 digits
    # @example
    #   validate_indicator("5300000041")  # true
    #   validate_indicator("53000000412") # false
    #   validate_indicator("")            # false
    #   validate_indicator("a")           # false
    # @param indicator [String] Indicator to be evaluated
    def self.validate_indicator(indicator)
      i_regex = /\A\d{10}\z/
      indicator =~ i_regex || raise(ArgumentError.new("Given indicator is not valid"))
    end
    
    # Validates that a location adheres to INEGI's format
    # It looks like locations have a format of 5 digits
    # @example
    #   validate_indicator("53000")       # true
    #   validate_indicator("53000000412") # false
    #   validate_indicator("")            # false
    #   validate_indicator("a")           # false
    # @param location [String] Location to be evaluated
    def self.validate_location(location)
      l_regex = /\A\d{5}\z/
      location =~ l_regex || raise(ArgumentError.new("Given location is not valid"))
    end
    
    ##
    # After validating indicator, call Inegifacil's service and return indexes.
    # @example
    #   indexes("5300000041") # HTTParty::Response[...]
    # @param indicator [String] 10 digits indicator
    # @param location [String] 5 digits location indicator
    def indexes(indicator, location = nil)
      self.class.validate_indicator indicator
      self.class.validate_location location if location
      path = "/#{indicator}/#{location}"
      indexes = self.class.get path
      self.class.format_indexes indexes
    end
    
    ##
    # From a hash with Inegifacil's structure, return a more readable one
    # @example
    #   hash = { "header": { "INDICADOR": "XXXXXXXXXX" },
    #            "indices": [{ "TIME_PERIOD": "YYYY", "OBS_VALUE": "Z" }] }
    # 
    #   format_indexes(hash) # { indicator: "XXXXXXXXXX", values: [..] }
    #                        # +values+ contains +period+, +value+ and +units+
    # @param hash [Hash] A hash containing results from service
    # @see http://inegifacil.com/rest/indice/1002000001
    def self.format_indexes(hash)
      result = { indicator: hash["header"]["INDICADOR"] }
      values = hash["indices"].map do |v|
        {
          period: v["TIME_PERIOD"],
          value: v["OBS_VALUE"],
          units: v["OBS_UNIT"]
        }
      end
      values = { values: values }
      result.merge values
    end
  end
end
