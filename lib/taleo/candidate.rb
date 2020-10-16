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

    has_one :employee, Employee
  end
end
