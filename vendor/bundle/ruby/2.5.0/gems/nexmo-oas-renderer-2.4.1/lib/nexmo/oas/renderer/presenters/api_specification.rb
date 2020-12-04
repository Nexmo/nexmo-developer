# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class ApiSpecification
          def initialize(document_name:, code_language: nil)
            @document_name = document_name
            @code_language = code_language
          end

          def side_navigation
            if defined?(NexmoDeveloper::Application)
              "#{Rails.configuration.docs_base_path}/api/#{@document_name}"
            else
              "api/#{@document_name}"
            end
          end

          def document_path
            if defined?(NexmoDeveloper::Application)
              "#{Rails.configuration.docs_base_path}/_api/#{@document_name}.md"
            else
              "_api/#{@document_name}.md"
            end
          end

          def document
            @document ||= File.read(document_path)
          end

          def frontmatter
            @frontmatter ||= YAML.safe_load(document)
          end

          def side_navigation_title
            @side_navigation_title ||= frontmatter.fetch('api')
          end

          def document_title
            @document_title ||= "#{side_navigation_title} > #{frontmatter.fetch('title')}"
          end

          def content
            options = {}
            options.merge(code_language: @code_language) if @code_language
            @content ||= Nexmo::Markdown::Renderer.new(options).call(document)
          end
        end
      end
    end
  end
end
