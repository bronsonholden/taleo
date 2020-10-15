require 'taleo/resource'

module Taleo
  class Candidate < Resource
    def id
      data.fetch('candId')
    end
  end
end
