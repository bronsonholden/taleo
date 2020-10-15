require 'taleo/resource'

module Taleo
  # Stub for Employee resource class
  class Employee < Resource; end

  # A collection of activities to complete for onboarding.
  class Packet < Resource
    def id
      data.fetch('activityPacketId')
    end

    def employee_id
      data.fetch('employeeId')
    end

    has_one :employee, Employee, through: 'employeeId'
  end
end
