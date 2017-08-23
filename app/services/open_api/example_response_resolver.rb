module OpenApi
  class ExampleResponseResolver
    attr_accessor :specification
    attr_accessor :path
    attr_accessor :method
    attr_accessor :status

    def initialize(specification, path:, method:, status: nil)
      @specification = specification
      @path = path
      @method = method
      @status = status

      validate
    end

    def model
      @model ||= parse(response_body_schema)
    end

    def response_body_schema
      endpoint.response_body_schema(status)
    end

    def json
      @json ||= model.to_json
    end

    def formatted_json
      JSON.pretty_generate(model)
    end

    def html
      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexer.find('json')
      highlighted_response = formatter.format(lexer.lex(formatted_json))

      output = <<~HEREDOC
        <br>
        <h3><span class="label">#{@status}</span> HTTP response:</h3>
        <pre class="highlight json"><code>#{ highlighted_response }</code></pre>
      HEREDOC

      output.html_safe
    end

    def server
      @specification.raw['servers'].first['url']
    end

    def treat_as_object?(object)
      return true if object['type'] == 'object'
      return true if object['allOf']
      return true if object['properties']
      false
    end

    def parse(root_object)
      case root_object['type']
      when 'object' then parse_object(root_object)
      when 'array' then parse_array(root_object)
      when nil
        return nil if root_object['additionalProperties'] == false
        return nil if root_object['properties'] == {}

        if treat_as_object?(root_object)
          # Handle objects with missing type
          return parse_object(root_object.merge({ 'type' => 'object' }))
        end

        ap root_object
        raise StandardError.new("Unhandled object with missing type")
      else
        raise StandardError.new("Don't know how to parse #{root_object['type']}")
      end
    end

    def parse_object(object)
      raise StandardError.new("Not a hash") unless object.class == Hash
      raise StandardError.new("Not an object") unless object['type'] == 'object'

      if object['allOf']
        merged_object = { 'type' => 'object' }
        object['allOf'].each { |o| merged_object = merged_object.deep_merge(o) }
        return parse_object(merged_object)
      elsif object['properties']
        o = {}
        object['properties'].each do |key, value|
          o[key] = parameter_value(value)
        end

        return o
      end

      {}
    end

    def parse_array(object)
      raise StandardError.new("Not an array") unless object['type'] == 'array'

      case object['items']['type']
      when 'object'
        [parse_object(object['items'])]
      else
        if object['items']
          # Handle objects with missing type
          object['items']['type'] = 'object'
          [parse_object(object['items'])]
        else
          raise StandardError.new("parse_array: Don't know how to parse object")
        end
      end
    end

    def resolved_path
      @resolved_path = @path.dup
      path_parameters.each do |path_parameter|
        @resolved_path.gsub! "{#{path_parameter['name']}}", parameter_value(path_parameter).to_s
      end

      @resolved_path
    end

    def status
      @status ||= endpoint.raw['responses'].keys.first.to_s
    end

    def jwt?
      return false unless endpoint.raw['security']
      endpoint.raw['security'].include? 'jwt'
    end

    def endpoint
      @endpoint ||= @specification.endpoint(resolved_path, @method)
    end

    def title
      endpoint.raw['summary'] || endpoint.raw['description']
    end

    def description
      endpoint.raw['description']
    end

    def request_body_parameters
      return [] unless endpoint.raw['requestBody']
      normalize_properties(endpoint.raw['requestBody']['content'].values[0]['schema']['properties'])
    end

    def path_parameters
      @path_parameters ||= parameters.select do |parameter|
        parameter['in'] == 'path'
      end
    end

    def query_parameters
      @query_parameters ||= parameters.select do |parameter|
        parameter['in'] == 'query'
      end
    end

    def normalize_properties(properties)
      properties.map { |key, value| { 'name' => key }.merge(value) }
    end

    private

    def parameters
      raise StandardError.new("Path (#{@path}) does not exist") unless @specification.raw['paths'][@path]
      raise StandardError.new("Method (#{method}) does not exist on path (#{@path})") unless @specification.raw['paths'][@path][@method]
      @parameters ||= @specification.raw['paths'][@path][@method]['parameters'] || []
    end

    def parameter_value(parameter)
      return parameter['example'] if parameter['example']
      case (parameter['schema'] ? parameter['schema']['type'] : parameter['type'])
      when 'integer' then return 1
      when 'number' then return 1.0
      when 'string' then return 'abc123'
      when 'boolean' then return false
      when 'object' then return parse_object(parameter)
      when 'array' then return parse_array(parameter)
      else
        raise StandardError.new("Can not resolve parameter type of #{parameter['type']}")
      end
    end

    def validate
      raise raise StandardError.new("Specification missing") unless @specification
      raise raise StandardError.new("Path missing") unless @path
      raise raise StandardError.new("Method missing") unless @method
      raise raise StandardError.new("Status missing") unless status
    end
  end
end
