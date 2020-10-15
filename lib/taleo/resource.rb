module Taleo
  class Resource
    attr_reader :data, :client

    def initialize(data, client)
      @data = data
      @client = client
    end

    # Define a has-one relationship with another resource
    def self.has_one(name, type, through: name, identifier: name)
      define_method(:"has_#{name}?") do
        relationship_urls.key?(through.to_s)
      end

      define_method(name) do
        related_resource(name.to_s, through, identifier, type)
      end
    end

    # Define a has-many relationship with another resource
    def self.has_many(name, type, through: name, singular: name, plural: name)
      define_method(:"has_#{name}?") do
        relationship_urls.key?(through.to_s)
      end

      define_method(name) do
        related_resources(name.to_s, type, through, singular, plural)
      end
    end

    # Retrieve a related resource's data
    def related_resource(name, through, identifier, type)
      unless self.send(:"has_#{name}?")
        raise Taleo::Error.new("No such relationship: #{name}")
      end

      res = client.connection.get do |req|
        req.url relationship_urls.fetch(through.to_s)
      end

      data = JSON.parse(res.body)
      type.new(data.dig('response', identifier.to_s), client)
    end

    # Retrieve a set of related resources' data
    def related_resources(name, type, through, singular, plural)
      unless self.send(:"has_#{name}?")
        raise Taleo::Error.new("No such relationship: #{name}")
      end

      res = client.connection.get do |req|
        req.url relationship_urls.fetch(through.to_s)
      end

      data = JSON.parse(res.body)
      data.dig('response', plural.to_s).map do |item|
        type.new(item.fetch(singular.to_s), client)
      end
    end

    # Get URLs for related resources
    def relationship_urls
      data.fetch('relationshipUrls')
    end
  end
end
