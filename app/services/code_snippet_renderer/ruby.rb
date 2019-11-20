module CodeSnippetRenderer
  class Ruby < Base
    def self.dependencies(deps)
      { 'code' => "gem install #{deps.join(' ')}" }
    end

    def self.run_command(command, _filename, _file_path)
      t('services.code_snippet_renderer.run_command', command: command)
    end

    def self.create_instructions(filename)
      t('services.code_snippet_renderer.create_instructions', filename: filename)
    end

    def self.add_instructions(filename)
      t('services.code_snippet_renderer.add_instructions_to_file', file: filename)
    end
  end
end
