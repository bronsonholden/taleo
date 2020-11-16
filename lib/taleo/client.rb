# frozen_string_literal: true

require 'taleo/cursor'
require 'taleo/activity'
require 'taleo/packet'
require 'taleo/candidate'
require 'taleo/employee'

module Taleo
  # Base object for executing queries and wrapping HTTP requests.
  class Client
    attr_reader :org_code, :username, :password, :service_url, :auth_token

    def initialize(org_code, username, password, service_url)
      @org_code = org_code
      @username = username
      @password = password
      @service_url = service_url
    end

    def employee(id)
      Employee.new(show('employee', id), self)
    end

    def packet(id)
      Packet.new(show('packet', id), self)
    end

    def candidate(id)
      Candidate.new(show('candidate', id), self)
    end

    def activity(id)
      Activity.new(show('activity', id), self)
    end

    def employees(start = 1, limit = 10, params: {})
      raise ArgumentError, "At least one query parameter is required " \
                           "for employee search" if params.keys.size.zero?
      cursor('employee', Employee, start, limit, params: params)
    end

    def cursor(resource, klass, start = 1, limit = 10, params: {})
      res = connection.get do |req|
        req.url "object/#{resource}/search"
        req.params.merge!(params).merge!({
          'start' => start,
          'limit' => limit
        })
      end
      data = JSON.parse(res.body)
      pagination = data.dig('response', 'pagination')
      results = data.dig('response', 'searchResults')
      cursor = Cursor.new(pagination, results, resource, klass, self)
      cursor.self_page
    end

    def show(resource, id)
      res = connection.get do |req|
        req.url "object/#{resource}/#{id}"
      end
      data = JSON.parse(res.body)
      data.dig('response', resource)
    end

    def login
      params = {
        orgCode: org_code,
        userName: username,
        password: password
      }

      conn = Faraday.new(url: api_url) do |c|
        c.use Faraday::Response::RaiseError
      end

      res = conn.post do |req|
        req.url 'login'
        req.params.merge!(params)
      end

      data = JSON.parse(res.body)
      @auth_token = data.dig('response', 'authToken')
    end

    def logout
      connection.post do |req|
        req.url 'logout'
      end
    end

    def api_url
      return @api_url if !@api_url.nil?

      api_url!
    end

    def connection
      Faraday.new(url: api_url) do |conn|
        conn.use Faraday::Response::RaiseError
        conn.headers['Cookie'] = "authToken=#{auth_token}"
      end
    end

    def download(url)
      io = StringIO.new
      connection.get do |req|
        req.url url
        req.options.on_data = Proc.new do |chunk|
          io << chunk
        end
      end
      io.rewind
      io
    end

    def api_url!
      conn = Faraday.new(url: "#{service_url}/#{org_code}") do |c|
        c.use Faraday::Response::RaiseError
      end
      res = conn.get
      data = JSON.parse(res.body)
      @api_url = data.dig('response', 'URL')
      @api_url
    end
  end
end
