# frozen_string_literal: true

require_relative './oas_parser'

module Nexmo
  module OAS
    module Renderer
      class OpenApiDefinitionResolver
        def self.find(name)
          path = paths(name).detect do |p|
            break p if File.file? p
          end

          return resolve(path) if path

          raise Errno::ENOENT, "Could not find definition '#{name}' in '#{API.oas_path}'"
        end

        def self.paths(name)
          %w[json yaml yml].map do |format|
            path(name, format)
          end
        end

        def self.path(name, format)
          "#{API.oas_path}/#{name}.#{format}"
        end

        def self.resolve(path)
          OasParser::Definition.resolve(path)
        end
      end
    end
  end
end
