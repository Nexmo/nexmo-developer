module OasParser
  class Parser
    def self.resolve(path)
      content = YAML.load_file(path)
      Parser.new(path, content).resolve
    end

    def initialize(path, content)
      @path = path
      @content = content
    end

    def resolve
      deeply_expand_refs(@content, nil)
    end

    private

    def deeply_expand_refs(fragment, path)
      fragment, current_path = expand_refs(fragment, path)

      if fragment.is_a?(Hash)
        fragment.reduce({}) do |hash, (k, v)|
          hash.merge(k => deeply_expand_refs(v, "#{current_path}/#{k}"))
        end
      elsif fragment.is_a?(Array)
        fragment.map { |e| deeply_expand_refs(e, current_path) }
      else
        fragment
      end
    end

    def expand_refs(fragment, current_path)
      unless fragment.is_a?(Hash) && fragment.key?("$ref")
        return [fragment, current_path]
      end

      ref = fragment["$ref"]

      if ref =~ /^#/
        expand_pointer(ref, current_path)
      elsif ref =~ /^(http(s)?|\/\/)/
        expand_url(ref)
      else
        expand_file(ref)
      end
    end

    def expand_file(ref)
      absolute_path = File.expand_path(File.join("..", ref), @path)
      absolute_path, local_reference = absolute_path.split('#')
      resolved_remote_reference = Parser.resolve(absolute_path)

      if local_reference
        pointer = OasParser::Pointer.new(local_reference)
        return pointer.resolve(resolved_remote_reference)
      end

      resolved_remote_reference
    end

    def expand_pointer(ref, current_path)
      pointer = OasParser::Pointer.new(ref)

      if pointer.circular_reference?(current_path)
        { "$ref" => ref }
      else
        fragment = pointer.resolve(@content)
        expand_refs(fragment, current_path + pointer.escaped_pointer)
      end
    end

    def expand_url(ref)
      raise 'Expanding URL References is not supported'
    end
  end
end
