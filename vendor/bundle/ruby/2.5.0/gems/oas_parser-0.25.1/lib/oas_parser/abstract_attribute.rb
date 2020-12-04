module OasParser
  class AbstractAttribute
    include OasParser::RawAccessor

    def initialize(name)
      @name = name
    end

    def name(format = nil)
      default = @name || raw['name']
      return default unless format
      case format
      when 'text/xml'
        has_xml_name? ? xml_name : default
      else default
      end
    end

    def enum
      raw['enum'] || (schema ? schema['enum'] : nil)
    end

    def allOf?
      raw['allOf'] ? true : false
    end

    def oneOf?
      raw['oneOf'] ? true : false
    end

    def array?
      type == 'array'
    end

    def object?
      type == 'object'
    end

    def collection?
      array? || object?
    end

    def empty?
      raise 'Called empty? on non collection type' unless collection?
      return true if object? && raw['properties'].blank?
      return true if array? && items.blank?
      false
    end

    def properties
      return convert_property_schema_to_properties(raw) if (oneOf? || allOf?)
      return nil unless collection?
      return [] if empty?
      return convert_property_schema_to_properties(raw['properties']) if object?
      return convert_property_schema_to_properties(items) if array?
      nil
    end

    def has_xml_options?
      raw['xml'].present?
    end

    def is_xml_attribute?
      return false unless has_xml_options?
      raw['xml']['attribute'] || false
    end

    def is_xml_text?
      # See: https://github.com/OAI/OpenAPI-Specification/issues/630#issuecomment-350680346
      return false unless has_xml_options?
      return true if raw['xml']['text'] || false
      raw['xml']['x-text'] || false
    end

    def has_xml_name?
      return false unless has_xml_options?
      xml_name || false
    end

    def xml_name
      raw['xml']['name']
    end

    def subproperties_are_one_of_many?
      return false unless array?
      items['oneOf'].present?
    end
  end
end
