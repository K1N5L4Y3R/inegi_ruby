# inegi_ruby

Inegifacil's REST service wrapper for Ruby apps

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inegi_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inegi_ruby

## Documentation
[Rubydoc](http://www.rubydoc.info/github/K1N5L4Y3R/inegi_ruby)

## Usage

```ruby
inegi = Inegi::Client.new

# Returns information for aggregated Mexican population
puts inegi.indexes "1002000001"
# {
#   indicator: "1002000001",
#   values: [
#     {
#       period: "1990",
#       value: "91829",
#       units: "Número de personas"
#     },
#     ...
#   ]
# }

# Returns information for population in specific location (Puebla)
puts inegi.indexes "1002000001", "21000"
# {
#   indicator: "1002000001",
#   values: [
#     {
#       period: "1990",
#       value: "9182",
#       units: "Número de personas"
#     },
#     ...
#   ]
# }
```

## Changelog

#### 0.1.1
* Fix gemspec to allow rubygems.org

#### 0.1.0
* Get indexes for an indicator
* `#indexes` accepts both an indicator and an optional location
* Indicators and locations are validated