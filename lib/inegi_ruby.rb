require "inegi_ruby/version"
require "httparty"

module Inegi
  class Client
    include HTTParty
    
    base_uri "http://inegifacil.com/rest/indice"
    
    ##
    # Validates that an index adheres to INEGI's format
    # It looks like indexes have a format of 10 digits
    # @example
    #   validate_indicator("5300000041")  # true
    #   validate_indicator("53000000412") # false
    #   validate_indicator("")            # false
    #   validate_indicator("a")           # false
    # @param index [String] Index to be evaluated
    def self.validate_indicator(index)
      i_regex = /\A\d{10}\z/
      index =~ i_regex || raise(ArgumentError.new("Given index is not valid"))
    end
    
    ##
    # After validating indicator, call Inegifacil's service and return indexes.
    # @example
    #   indexes("5300000041") # HTTParty::Response[...]
    def indexes(indicator)
      self.class.validate_indicator indicator
      indexes = self.class.get "/#{indicator}"
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
