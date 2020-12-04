module Nexmo
  module Markdown
    module CodeSnippetRenderer
      class Curl < Base
        def self.dependencies(deps, _version)
          dependencies = deps.map(&:upcase)
          raise t('.only_permitted_dependency') unless dependencies.include?('JWT')
          {
            'text' => t('services.code_snippet_renderer.curl.text'),
            'code' => 'export JWT=$(nexmo jwt:generate $PATH_TO_PRIVATE_KEY application_id=$NEXMO_APPLICATION_ID)',
          }
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
