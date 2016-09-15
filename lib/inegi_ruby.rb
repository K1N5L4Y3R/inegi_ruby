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
    #   validate_index("5300000041")  # true
    #   validate_index("53000000412") # false
    #   validate_index("")            # false
    #   validate_index("a")           # false
    # @param index [String] Index to be evaluated
    def self.validate_index(index)
      i_regex = /\A\d{10}\z/
      index =~ i_regex || raise(ArgumentError.new("Given index is not valid"))
    end
  end
end
