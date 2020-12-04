# frozen_string_literal: true

require 'forwardable'
require_relative './endpoint'
require_relative './response_format'
require_relative './groups'
require_relative './versions'
require_relative '../services/open_api_definition_resolver'

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class OpenApiSpecification
          extend Forwardable

          attr_reader :definition_name

          def_delegators :@versions, :current_version, :available_versions
          def_delegators :@groups, :groups

          def initialize(definition_name:, expand_responses:)
            @definition_name  = definition_name
            @expand_responses = expand_responses
            @versions         = Versions.new(definition_name)
            @groups           = Groups.new(definition)
          end

          def errors?
            File.exist?("#{API.oas_path}/../../errors/#{@definition_name}.md")
          end

          def definition_errors
            return unless errors?

            @definition_errors ||= Nexmo::Markdown::Renderer.new.call(
              File.read("#{API.oas_path}/../../errors/#{@definition_name}.md")
            )
          end

          def definition
            @definition ||= OpenApiDefinitionResolver.find(@definition_name)
          end

          def auto_expand_responses
            @expand_responses
          end

          def formats
            @formats ||= ResponseFormat.to_dropdown(endpoints.flat_map(&:formats).uniq)
          end

          private

          def endpoints
            @endpoints ||= definition.endpoints.map { |e| Endpoint.new(e) }
          end
        end
      end
    end
  end
end
