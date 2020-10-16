# frozen_string_literal: true

require 'json'
require 'faraday'
require 'taleo/version'
require 'taleo/client'

module Taleo
  class Error < StandardError; end
end
