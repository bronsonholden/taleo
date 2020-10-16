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

      url = relationship_urls.fetch('formDownloadUrl')

      io = StringIO.new
      client.connection.get do |req|
        req.url url
        req.options.on_data = Proc.new do |chunk, total_bytes|
          io << chunk
        end
      end
      io.rewind
      io
    end

    has_one :employee, Employee, through: 'activityEmployee'
  end
end
