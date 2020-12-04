require 'forwardable'

module Nexmo
  module Markdown
    module Filters
      module CodeSnippet
        module Renderable
          extend Forwardable

          def_delegators :@snippet, :language, :lang, :renderer, :lexer, :unindent, :file_name, :source, :import_dependencies?

          def id
            @id ||= SecureRandom.hex
          end

          def client_url
            @client_url ||= ::Nexmo::Markdown::Utils.generate_source_url(@config)
          end

          def renderer
            case normalized_language
            when 'curl'
              Nexmo::Markdown::CodeSnippetRenderer::Curl
            when 'node'
              Nexmo::Markdown::CodeSnippetRenderer::Javascript
            when 'javascript'
              Nexmo::Markdown::CodeSnippetRenderer::Javascript
            when 'java'
              Nexmo::Markdown::CodeSnippetRenderer::Java
            when 'dotnet'
              Nexmo::Markdown::CodeSnippetRenderer::Dotnet
            when 'python'
              Nexmo::Markdown::CodeSnippetRenderer::Python
            when 'ruby'
              Nexmo::Markdown::CodeSnippetRenderer::Ruby
            when 'php'
              Nexmo::Markdown::CodeSnippetRenderer::Php
            when 'android'
              Nexmo::Markdown::CodeSnippetRenderer::Android
            when 'kotlin'
              Nexmo::Markdown::CodeSnippetRenderer::Kotlin
            when 'objective_c'
              Nexmo::Markdown::CodeSnippetRenderer::ObjectiveC
            when 'swift'
              Nexmo::Markdown::CodeSnippetRenderer::Swift
            when 'go'
              Nexmo::Markdown::CodeSnippetRenderer::Go
            else
              raise "Unknown language: #{normalized_language}"
            end
          end

          def normalized_language
            if language == 'csharp'
              'dotnet'
            else
              language
            end
          end
        end
      end
    end
  end
end
