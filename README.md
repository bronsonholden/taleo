# Taleo

[![Gem Version](https://badge.fury.io/rb/taleo.svg)](https://badge.fury.io/rb/taleo) [![Build Status](https://travis-ci.org/paulholden2/taleo.svg?branch=master)](https://travis-ci.org/paulholden2/taleo) [![Inline docs](http://inch-ci.org/github/paulholden2/taleo.svg?branch=master)](http://inch-ci.org/github/paulholden2/taleo) [![Maintainability](https://api.codeclimate.com/v1/badges/18630172a2dc24e7ace1/maintainability)](https://codeclimate.com/github/paulholden2/taleo/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/18630172a2dc24e7ace1/test_coverage)](https://codeclimate.com/github/paulholden2/taleo/test_coverage)

A library for using the Taleo REST API.

**Note**: A Nov 2020 change to the Taleo API requires at least one search
criteria be passed to employee searches (performed by `client#employees` to
retrieve paged results). Versions prior to 0.6 do not support passing search
parameters, and as such you should not use them if you need to utilize
employee searches. See the Taleo REST API guide
[here](https://www.oracle.com/technical-resources/documentation/taleobusiness.html)
for more information.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'taleo'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install taleo

## Usage

Check back later.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/paulholden2/taleo.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Be cool.
