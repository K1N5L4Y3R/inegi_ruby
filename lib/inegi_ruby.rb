require "inegi_ruby/version"
require "httparty"

module Inegi
  class Client
    include HTTParty
    
    BASE_URL = "http://inegifacil.com/rest/indice"
  end
end
