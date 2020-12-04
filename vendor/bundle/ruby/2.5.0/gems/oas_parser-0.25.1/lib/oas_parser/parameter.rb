module OasParser
  class Parameter < AbstractAttribute
    raw_keys :in, :description, :style, :schema,
             :minimum, :maximum, :required

    attr_accessor :owner, :raw

    def initialize(owner, raw)
      super(raw['name'])
      @owner = owner
      @raw = raw
    end

    def type
      raw['type'] || (schema ? schema['type'] : nil)
    end

    def format
      raw['format'] || (schema ? schema['format'] : nil)
    end

    def items
      schema['items']
    end

    def example
      raw['example'] || (schema ? schema['example'] : nil)
    end

    def default
      raw['default'] || (schema ? schema['default'] : nil)
    end

    def convert_property_schema_to_properties(schema)
      schema.map do |name, definition|
        OasParser::Property.new(self, raw, name, definition)
      end
    end
  end
end
