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

    has_one :employee, Employee, through: 'activityEmployee'
  end
end
