module OasParser
  class Pointer
    def initialize(raw_pointer)
      @raw_pointer = raw_pointer
    end

    def resolve(document)
      return document if escaped_pointer == ""

      tokens.reduce(document) do |nested_doc, token|
        nested_doc.fetch(token)
      end
    end

    # Detect circular reference by checking whether the ref exists in current path.
    #
    # Example:
    # components:
    #   schemas:
    #     Pet:
    #       type: object
    #       properties:
    #         name:
    #           type: string
    #         children:
    #           type: array
    #           items: # <--- parsing here
    #             - $ref: '#/components/schemas/Pet'
    #
    # path: "/components/schemas/Pet/properties/children/items"
    # raw_pointer: "#/components/schemas/Pet"
    #
    # It'd return true when we're parsing the pet children items where the ref points back to itself.
    def circular_reference?(path)
      path.include?("#{escaped_pointer}/")
    end

    def escaped_pointer
      if @raw_pointer.start_with?("#")
        Addressable::URI.unencode(@raw_pointer[1..-1])
      else
        @raw_pointer
      end
    end

    private

    def parse_token(token)
      token.gsub("~0", "~").gsub("~1", "/")
    end

    def tokens
      tokens = escaped_pointer[1..-1].split("/")

      if @raw_pointer.end_with?("/")
        tokens << ""
      end

      tokens.map do |token|
        parse_token(token)
      end
    end
  end
end
