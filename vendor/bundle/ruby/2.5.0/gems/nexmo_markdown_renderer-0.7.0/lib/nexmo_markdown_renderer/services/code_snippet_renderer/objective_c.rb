module Nexmo
  module Markdown
    module CodeSnippetRenderer
      class ObjectiveC < Base
        def self.dependencies(_deps, _version)
          {
            'text' => 'See <a href="/client-sdk/setup/add-sdk-to-your-app/ios">How to Add the Nexmo Client SDK to your iOS App</a>',
          }
        end
    
        def self.run_command(_command, _filename, _file_path)
          nil
        end
    
        def self.create_instructions(filename)
          ::I18n.t('services.code_snippet_renderer.create_instructions', filename: filename)
        end
    
        def self.add_instructions(_filename)
          ::I18n.t('services.code_snippet_renderer.add_instructions_to_code')
        end
      end
    end    
  end
end