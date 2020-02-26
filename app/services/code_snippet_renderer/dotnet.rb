module CodeSnippetRenderer
  class Dotnet < Base
    def self.dependencies(deps)
      { 'code' => "Install-Package #{deps.join(' ')}" }
    end

    def self.run_command(_command, _filename, _file_path)
      nil
    end

    def self.create_instructions(filename)
      t('services.code_snippet_renderer.create_instructions', filename: filename)
    end

    def self.add_instructions(filename)
      t('services.code_snippet_renderer.add_instructions_to_file', file: filename)
    end
  end
end
