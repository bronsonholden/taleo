require 'json'
require 'faraday'
require 'taleo/version'
require 'taleo/resource'
require 'taleo/client'
require 'taleo/candidate'
require 'taleo/employee'
require 'taleo/packet'

module Taleo
  class Error < StandardError; end
end
