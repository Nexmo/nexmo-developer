module Nexmo
  module Markdown
    module CodeSnippetRenderer
      class Kotlin < Base
        def self.dependencies(deps, _version)
          {
            'text' => 'See <a href="https://developer.nexmo.com/use-cases/client-sdk-android-add-sdk-to-your-app">How to Add the Nexmo Client SDK to your Android App</a>',
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