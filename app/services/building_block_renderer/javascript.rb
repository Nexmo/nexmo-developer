module BuildingBlockRenderer
  class Javascript
    def self.dependencies(deps)
      { 'code' => "$ npm install #{deps.join(' ')}" }
    end

    def self.run_command(command, _filename, _file_path)
      <<~HEREDOC
        ## Run your code
         Save this file to your machine and run it:
         <pre class="highlight bash"><code>$ #{command}</code></pre>

      HEREDOC
    end
  end
end
