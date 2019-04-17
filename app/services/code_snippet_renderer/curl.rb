module CodeSnippetRenderer
  class Curl
    def self.dependencies(deps)
      dependencies = deps.map(&:upcase)
      raise 'The only permitted curl dependency is `jwt`' unless dependencies.include?('JWT')
      {
        'text' => 'Execute the following command at your terminal prompt to create the <a href="/concepts/guides/authentication#json-web-tokens-jwt">JWT</a> for authentication:',
        'code' => 'export JWT=\'$(nexmo jwt:generate $PATH_TO_PRIVATE_KEY application_id=$NEXMO_APPLICATION_ID)\'',
      }    
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
