module CodeSnippetRenderer
  class Javascript
    def self.dependencies(deps)
      { 'code' => "npm install #{deps.join(' ')}" }
    end

    def self.run_command(command, _filename, _file_path)
      <<~HEREDOC
        ## Run your code
         Save this file to your machine and run it:
         <pre class="highlight bash run-command"><code>#{command}</code></pre>

      HEREDOC
    end

    def self.create_instructions(filename)
      "<p>Create a file named <code>#{filename}</code> and add the following code:</p>"
    end

    def self.add_instructions(filename)
      "<p>Add the following to <code>#{filename}</code>:</p>"
    end
  end
end
