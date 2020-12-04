module Nexmo
  module Markdown
    module Filters
      module CodeSnippet
        class Binding
          def initialize(config)
            @config = config
          end

          def language
            @language ||= @config['language']
          end

          def lexer
            @lexer ||= Nexmo::Markdown::CodeLanguage.find(language).lexer
          end

          def lang
            @lang ||= @config['title'].delete('.')
          end

          def unindent
            @unindent ||= @config['unindent']
          end

          def file_name
            @file_name ||= @config['file_name']
          end

          def source
            @source ||= @config['source']
          end

          def import_dependencies?
            @config['import_dependencies']
          end
        end
      end
    end
  end
end
