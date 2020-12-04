module Nexmo
  module Markdown
    module CodeSnippetRenderer
      class Python < Base
        def self.dependencies(deps, _version)
          { 'code' => "pip install #{deps.join(' ')}" }
        end
    
        def self.run_command(command, _filename, _file_path)
          ::I18n.t('services.code_snippet_renderer.run_command', command: command)
        end
    
        def self.create_instructions(filename)
          ::I18n.t('services.code_snippet_renderer.create_instructions', filename: filename)
        end
    
        def self.add_instructions(filename)
          ::I18n.t('services.code_snippet_renderer.add_instructions_to_file', file: filename)
        end
      end
    end    
  end
end