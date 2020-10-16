require 'taleo/resource'
require 'taleo/candidate'
require 'taleo/packet'

module Taleo
  # Stub for Packet resource class
  class Packet < Resource; end

  class Employee < Resource
    def id
      data.fetch('employeeId')
    end

    has_one :candidate, Candidate
    has_many :packets, Packet, singular: 'packet', plural: 'activityPackets'
  end
end
