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

    def ssn
      data.fetch('ssn')
    end

    has_one :candidate, Candidate
    has_one :location, Location
    has_many :packets, Packet, singular: 'packet', plural: 'activityPackets'
    has_many :attachments, Attachment, singular: 'attachment', through: 'attachment'

    # Override since employee relationship URLs will not include an
    # attachments URL
    def has_attachments?
      true
    end

    # Annoying hack since the employee resource relationship URLs hash
    # doesn't include an attachments link, even if there are attachments.
    def relationship_urls
      urls = super
      urls.merge({
        'attachment' => urls.fetch('historylog').gsub(/historylog$/, 'attachment')
      })
    end
  end
end
