# frozen_string_literal: true

module Taleo
  # Pages through results of a search query
  class Cursor
    attr_reader :pagination, :results, :resource, :klass, :client

    def initialize(pagination, results, resource, klass, client)
      @pagination = pagination
      @results = results
      @resource = resource
      @klass = klass
      @client = client
    end

    def items
      results.map do |i|
        klass.new(i.fetch(resource), client)
      end
    end

    def has_next?
      pagination.key?('next')
    end

    def has_previous?
      pagination.key?('previous')
    end

    def next_page
      raise Taleo::Error.new('No further results') unless has_next?

      res = client.connection.get do |req|
        req.url pagination.fetch('next')
      end

      new_cursor(res)
    end

    def previous_page
      raise Taleo::Error.new('No prior results') unless has_previous?

      res = client.connection.get do |req|
        req.url pagination.fetch('previous')
      end

      new_cursor(res)
    end

    private

    def new_cursor(res)
      data = JSON.parse(res.body)
      pagination = data.dig('response', 'pagination')
      results = data.dig('response', 'searchResults')
      Cursor.new(pagination, results, client)
    end
  end
end
