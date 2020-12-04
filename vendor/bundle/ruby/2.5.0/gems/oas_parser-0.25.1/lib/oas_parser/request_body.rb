module OasParser
  class RequestBody < Payload
    include OasParser::RawAccessor
    raw_keys :description, :required, :content

    attr_accessor :endpoint, :raw

    def initialize(endpoint, raw)
      @endpoint = endpoint
      @raw = raw
    end

    def properties_for_format(format)
      s = schema(format)
      s = handle_all_of(s)
      s['properties'].map do |name, definition|
        OasParser::Property.new(self, s, name, definition)
      end
    end

    def split_properties_for_format(format)
      split_schemas(format).map do |schema|
        schema = handle_all_of(schema)
        schema['properties'].map do |name, definition|
          OasParser::Property.new(self, schema, name, definition)
        end
      end
    end

    def handle_all_of(schema)
      newSchema = {}
      if schema['allOf']
        schema['allOf'].each do |p|
          newSchema = deep_safe_merge(newSchema, p)
          if newSchema['allOf']
            newSchema = deep_safe_merge(newSchema, handle_all_of(newSchema))
            newSchema.delete('allOf')
          end
        end
      else
        newSchema = schema
      end

      newSchema
    end

     def deep_safe_merge(source_hash, new_hash)
       source_hash.merge(new_hash) do |key, old, new|
         if new.respond_to?(:blank) && new.blank?
           old
         elsif (old.kind_of?(Hash) and new.kind_of?(Hash))
           old.deep_merge(new)
         elsif (old.kind_of?(Array) and new.kind_of?(Array))
           old.concat(new).uniq
         else
           new
         end
       end
     end
  end
end
