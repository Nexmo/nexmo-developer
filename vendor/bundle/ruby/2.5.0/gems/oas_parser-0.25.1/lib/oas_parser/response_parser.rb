module OasParser
  class ResponseParser
    attr_accessor :raw

    def initialize(raw)
      @raw = raw
    end

    def parse(mode = nil)
      @mode = mode
      route(@raw)
    end

    def json
      parse('json').to_json
    end

    def xml(xml_options = {})
      xml_options ||= {}
      xml_options = default_xml_options.merge(xml_options)

      raw_xml = parse('xml').to_xml(xml_options)

      xml_document = Nokogiri::XML(raw_xml)

      xml_document.xpath('//__attributes').each do |attributes|
        attributes.children.each do |attribute|
          next unless attribute.class == Nokogiri::XML::Element
          attribute.parent.parent.css("> #{attribute.name}").remove
          attribute.parent.parent[attribute.name] = attribute.content
        end
      end

      xml_document.xpath('//__array_attributes').each do |attributes|
        attributes.children.each do |attribute|
          next unless attribute.class == Nokogiri::XML::Element

          parameter = {}
          parameter['example'] = attribute.css('example').text if attribute.css('example')
          parameter['type'] = attribute.css('type').text if attribute.css('type')

          attribute.parent.parent.parent[attribute.name] = parameter_value(parameter)
        end
        attributes.parent.remove
      end

      xml_document.xpath('//__text').each do |attribute|
        value = attribute.children.last.content
        attribute.parent.content = value
      end

      xml_document.xpath('//__attributes').each(&:remove)

      xml_document.to_xml.each_line.reject { |x| x.strip == '' }.join
    end

    private

    def default_xml_options
      {
        dasherize: false,
        skip_types: true,
      }
    end

    def route(root_object)
      case root_object['type']
      when 'object'
        parse_object(root_object)
      when 'array' then parse_array(root_object)
      when 'string' then root_object['example']
      when 'integer' then root_object['example']
      when 'number' then root_object['example']
      when nil
        return nil if root_object['additionalProperties'] == false
        return nil if root_object['properties'] == {}

        if treat_as_object?(root_object)
          # Handle objects with missing type
          return parse_object(root_object.merge({ 'type' => 'object' }))
        end

        raise StandardError.new("Unhandled object #{root_object} with missing type")
      else
        raise StandardError.new("Don't know how to parse #{root_object['type']}")
      end
    end

    def parse_object(object)
      raise StandardError.new("Not a hash") unless object.class == Hash
      raise StandardError.new("Not an object") unless treat_as_object?(object)

      if object['allOf']
        merged_object = { 'type' => 'object' }
        object['allOf'].each { |o| merged_object.deep_merge!(o) }
        return parameter_value(merged_object)
      elsif object['properties']
        o = {}
        object['properties'].each do |key, value|
          if @mode == 'xml'
            if is_xml_attribute?(value)
              o['__attributes'] ||= {}
              o['__attributes'][key] = parameter_value(value)
            end

            if is_xml_text?(value)
              o['__text'] = parameter_value(value)
            end

            if has_xml_name?(value)
              key = xml_name(value)
            end
          end

          o[key] = parameter_value(value)
        end

        return o
      end

      {}
    end

    def parse_array(object)
      raise StandardError.new("Not an array") unless object['type'] == 'array'

      attributes = {}

      if object['properties']
        if @mode == 'xml'
          object['properties'].each do |key, value|
            if is_xml_attribute?(value)
              attributes[key] = value
            end
          end
        end
      end

      if object['items'] && (object['items']['oneOf'] || object['items']['anyOf'])
        key = object['items']['oneOf'] ? 'oneOf' : 'anyOf'
        items = object['items'][key].map do |obj|
          route(obj)
        end

        items.push({ '__array_attributes' => attributes }) if attributes.any? && @mode == 'xml'
        return items
      end

      case object['items']['type']
      when 'object'
        if attributes.any? && @mode == 'xml'
          [parse_object(object['items']), { '__array_attributes' => attributes }]
        else
          [parse_object(object['items'])]
        end
      else
        if object['items']
          # Handle objects with missing type
          object['items']['type'] = 'object'
          if @mode == 'xml'
            [parse_object(object['items']), { '__array_attributes' => attributes }]
          else
            [parse_object(object['items'])]
          end
        else
          raise StandardError.new("parse_array: Don't know how to parse object")
        end
      end
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
        if treat_as_object?(parameter)
          return parse_object(parameter)
        end

        if parameter['type']
          raise StandardError.new("Can not resolve parameter type of #{parameter['type']}")
        else
          raise StandardError.new("Parameter #{parameter} is missing type.")
        end
      end
    end


    def treat_as_object?(object)
      return true if object['type'] == 'object'
      return true if object['allOf']
      return true if object['oneOf']
      return true if object['properties']
      false
    end

    def has_xml_options?(object)
      object['xml'].present?
    end

    def is_xml_attribute?(object)
      return false unless has_xml_options?(object)
      object['xml']['attribute'] || false
    end

    def is_xml_text?(object)
      # See: https://github.com/OAI/OpenAPI-Specification/issues/630#issuecomment-350680346
      return false unless has_xml_options?(object)
      return true if object['xml']['text'] || false
      object['xml']['x-text'] || false
    end

    def has_xml_name?(object)
      return false unless has_xml_options?(object)
      xml_name(object) || false
    end

    def xml_name(object)
      object['xml']['name']
    end
  end
end
