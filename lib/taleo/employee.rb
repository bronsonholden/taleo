require 'taleo/resource'
require 'taleo/candidate'
require 'taleo/packet'

module Taleo
  class Employee < Resource
    def id
      data.fetch('employeeId')
    end

    has_one :candidate, Candidate
    has_many :packets, Packet, singular: 'packet', plural: 'activityPackets'
  end
end
