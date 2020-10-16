# frozen_string_literal: true

require 'taleo/resource'

module Taleo
  # Stub for Employee resource class
  class Employee < Resource; end

  class Activity < Resource
    def id
      data.fetch('id')
    end

    def employee_id
      data.fetch('activityEmployee')
    end

    def can_download?
      relationship_urls.key?('formDownloadUrl')
    end

    def download
      unless can_download?
        raise Error.new("Activity #{id} is not available for download")
      end

      client.download(relationship_urls.fetch('formDownloadUrl'))
    end

    has_one :employee, Employee, through: 'activityEmployee'
  end
end
