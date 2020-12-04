module OasParser
  class Path
    attr_accessor :owner, :path, :raw

    def initialize(owner, path, raw)
      @owner = owner
      @path = path
      @raw = raw
    end

    def endpoints
      a = raw.map do |method, definition|
        next unless %w[get head post put patch delete trace options].include? method
        OasParser::Endpoint.new(self, method, definition)
      end

      a.compact
    end

    def endpoint_by_method(method)
      definition = raw[method]
      raise OasParser::MethodNotFound.new("HTTP method not found: '#{method}'") unless definition
      OasParser::Endpoint.new(self, method, definition)
    end

    def parameter_keys
      path.scan(/{(.+?)}/).flatten
    end

    def parameters
      return [] unless raw['parameters']
      raw['parameters'].map do |definition|
        OasParser::Parameter.new(self, definition)
      end
    end

    def definition
      owner if owner.class == OasParser::Definition
    end

    def callback
      owner if owner.class == OasParser::Callback
    end
  end
end
