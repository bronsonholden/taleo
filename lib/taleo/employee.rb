# frozen_string_literal: true

require 'taleo/resource'
require 'taleo/candidate'
require 'taleo/packet'
require 'taleo/location'

module Taleo
  # Stub for Packet resource class
  class Packet < Resource; end

  class Employee < Resource
    def id
      data.fetch('employeeId')
    end

    def first_name
      data.fetch('firstName')
    end

    def last_name
      data.fetch('lastName')
    end

    def location_id
      data.fetch('location')
    end

    has_one :candidate, Candidate
    has_one :location, Location
    has_many :packets, Packet, singular: 'packet', plural: 'activityPackets'
  end
end
