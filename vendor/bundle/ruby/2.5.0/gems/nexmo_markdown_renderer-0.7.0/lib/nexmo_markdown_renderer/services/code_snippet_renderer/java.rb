module Nexmo
  module Markdown
    module CodeSnippetRenderer
      class Java < Base
        def self.dependencies(deps, version)
          raise "'version' not provided for Java snippet" unless version
          {
            'text' => ::I18n.t('services.code_snippet_renderer.add_instructions_to_file', file: 'build.gradle'),
            'code' => deps.map { |d| "compile '#{d.gsub('@latest', version)}'" }.join('<br />'),
            'type' => 'groovy',
          }
        end

        def self.run_command(_command, filename, file_path)
          package = file_path.gsub('.repos/vonage/vonage-java-code-snippets/src/main/java/', '').tr('/', '.').gsub(filename, '')
          file = filename.gsub('.java', '')
          main = "#{package}#{filename.gsub('.java', '')}"
          chomped_package = package.chomp('.')

          ::I18n.t('services.code_snippet_renderer.java.run_command', chomped_package: chomped_package, package: package, main: main, file: file)
        end

        def self.create_instructions(filename)
          ::I18n.t('services.code_snippet_renderer.java.create_instructions', file: filename.gsub('.java', ''))
        end

        def self.add_instructions(filename)
          ::I18n.t('services.code_snippet_renderer.java.add_instructions', file: filename.gsub('.java', ''))
        end
      end
    end
  end
end
