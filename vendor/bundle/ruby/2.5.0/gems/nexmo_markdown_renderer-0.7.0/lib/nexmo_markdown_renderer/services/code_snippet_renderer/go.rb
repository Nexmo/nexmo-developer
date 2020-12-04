module Nexmo
  module Markdown
    module CodeSnippetRenderer
      class Go < Base
        def self.dependencies(deps, _version)
          { 'code' => "go get #{deps.join(' ')}" }
        end
    
        def self.run_command(command, _filename, _file_path)
          ::I18n.t('services.code_snippet_renderer.run_command', command: command)
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
