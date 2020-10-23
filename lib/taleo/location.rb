require 'taleo/resource'

module Taleo
  class Location < Resource
    def id
      data.fetch('id')
    end

    def name
      data.fetch('locationName')
    end
  end
end
