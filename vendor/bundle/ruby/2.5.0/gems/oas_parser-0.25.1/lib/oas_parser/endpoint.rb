module OasParser
  class Endpoint
    include OasParser::RawAccessor
    raw_keys :summary, :description, :operationId, :tags, :required

    attr_accessor :path, :method, :raw

    def initialize(path, method, raw)
      @path = path
      @method = method
      @raw = raw
    end

    def definition
      path.definition
    end

    def operation_id
      operationId
    end

    def parameters
      security_schema_parameters + local_parameters + path.parameters
    end

    def path_parameters
      parameters.select { |parameter| parameter.in == 'path' }
    end

    def query_parameters
      parameters.select { |parameter| parameter.in == 'query' }
    end

    def security_schema_parameters
      raw_security_schema_parameters = security_schemes.select do |security_schema|
        security_schema['in'].present? && security_schema['in'].present?
      end

      security_schema_parameter_defaults = {
        'type' => 'string',
        'example' => 'abc123',
        'default' => false,
      }

      raw_security_schema_parameters.map do |definition|
        definition = security_schema_parameter_defaults.merge(definition)
        OasParser::Parameter.new(self, definition)
      end
    end

    def parameter_by_name(name)
      parameters.each do |parameter|
        return parameter if parameter.name == name
      end

      raise OasParser::ParameterNotFound.new("Parameter not found: '#{name}'")
    end

    def request_body
      return false unless raw['requestBody']
      OasParser::RequestBody.new(self, raw['requestBody'])
    end

    def responses
      raw['responses'].map do |code, definition|
        OasParser::Response.new(self, code, definition)
      end
    end

    def response_by_code(code, use_default: false)
      definition = raw['responses'][code]
      definition ||= raw['responses']['default'] if use_default
      raise OasParser::ResponseCodeNotFound.new("Response code not found: '#{code}'") unless definition
      OasParser::Response.new(self, code, definition)
    end

    def security
      raw['security'] || []
    end

    def callbacks
      return [] unless raw['callbacks']
      raw['callbacks'].map do |name, definition|
        OasParser::Callback.new(self, name, definition)
      end
    end

    def callback_by_name(name)
      definition = raw['callbacks'][name]
      raise OasParser::CallbackNotFound.new("Callback not found: '#{name}'") unless definition
      OasParser::Callback.new(self, name, definition)
    end

    def jwt?
      return false unless security

      security_schemes.each do |security_schema|
        return true if security_schema['bearerFormat'] == 'JWT'
      end

      false
    end

    def basic_auth?
      return false unless security

      security_schemes.each do |security_schema|
        return true if security_schema['type'] == 'http' && security_schema['scheme'] == 'basic'
      end

      false
    end

    def security_schemes
      security_schemes = security.flat_map(&:keys)

      if definition
        security_schemes = security_schemes + definition.security.flat_map(&:keys)
      end

      security_schemes = security_schemes.uniq

      security_schemes.map do |security_scheme_name|
        definition.components['securitySchemes'][security_scheme_name]
      end
    end

    private

    def local_parameters
      return [] unless raw['parameters']
      raw['parameters'].map do |definition|
        OasParser::Parameter.new(self, definition)
      end
    end
  end
end
