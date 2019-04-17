module CodeSnippetRenderer
  class Curl
    def self.dependencies(_deps)
      deps = _deps.map(&:upcase)
      if deps.include?('JWT') then
        {
          'text' => 'Run the following <code>curl</code> command to create the <a href="/concepts/guides/authentication#json-web-tokens-jwt">JWT</a> for authentication:',
          'code' => 'export JWT=\'$(nexmo jwt:generate $PATH_TO_PRIVATE_KEY application_id=$NEXMO_APPLICATION_ID)\'',
        }
      else raise 'The only permitted curl dependency is `jwt`'
      end
    end

    def self.run_command(command, _filename, _file_path)
      <<~HEREDOC
        ## Run your code
         Save this file to your machine and run it:
         <pre class="highlight bash run-command"><code>#{command}</code></pre>

      HEREDOC
    end

    def self.create_instructions(filename)
      "Create a file named `#{filename}` and add the following code:"
    end

    def self.add_instructions(filename)
      "Add the following to `#{filename}`:"
    end
  end
end
