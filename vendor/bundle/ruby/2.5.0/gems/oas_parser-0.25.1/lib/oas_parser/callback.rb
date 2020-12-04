module OasParser
  class Callback < Payload
    include OasParser::RawAccessor
    raw_keys :description, :content

    attr_accessor :endpoint, :name, :raw

    def initialize(endpoint, name, raw)
      @endpoint = endpoint
      @name = name
      @raw = raw
    end

    def paths
      raw.map do |path, definition|
        OasParser::Path.new(self, path, definition)
      end
    end
  end
end
