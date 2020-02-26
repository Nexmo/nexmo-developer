module CodeSnippetRenderer
  class Android < Base
    def self.dependencies(_deps)
      {
        'text' => 'See <a href="https://developer.nexmo.com/use-cases/client-sdk-android-add-sdk-to-your-app">How to Add the Nexmo Client SDK to your Android App</a>',
      }
    end

    def self.run_command(_command, _filename, _file_path)
      nil
    end

    def self.create_instructions(filename)
      t('services.code_snippet_renderer.create_instructions', filename: filename)
    end

    def self.add_instructions(_filename)
      t('services.code_snippet_renderer.add_instructions_to_code')
    end
  end
end
