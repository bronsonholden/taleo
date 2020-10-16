require 'taleo/resource'

module Taleo
  # Stub Employee class
  class Employee < Resource; end

  class Candidate < Resource
    def id
      data.fetch('candId')
    end

    def employee_id
      data.fetch('employee')
    end

    def has_resume?
      relationship_urls.key?('resume')
    end

    def resume
      unless has_resume?
        raise Error.new("Candidate #{id} has no resume available for download")
      end

      client.download(relationship_urls.fetch('resume'))
    end

    has_one :employee, Employee
  end
end
