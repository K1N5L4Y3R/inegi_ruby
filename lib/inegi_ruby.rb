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
    # After validating indicator, call INEGI's service and return indexes.
    # @example
    #   indexes("5300000041") # HTTParty::Response[...]
    def indexes(indicator)
      self.class.validate_indicator indicator
      self.class.get "/#{indicator}"
    end
  end
end
