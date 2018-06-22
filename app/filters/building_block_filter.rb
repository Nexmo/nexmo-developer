class BuildingBlockFilter < Banzai::Filter
  def call(input)
    input.gsub(/```single_building_block(.+?)```/m) do |_s|
      config = YAML.safe_load($1)

      lexer = language_to_lexer(config['language'])

      application_html = generate_application_block(config['application']);

      # Read the client
      if config['client']
          highlighted_client_source = generate_code_block(config['language'], config['client'], config['unindent'])
      end

      # Read the code
      highlighted_code_source = generate_code_block(config['language'], config['code'], config['unindent'])

      dependency_html = ''
      if config['dependencies']
          dependency_html = generate_dependencies(lexer.tag, config['dependencies'])
      end

      client_html = ""
      if highlighted_client_source
      id = SecureRandom.hex
      client_html = <<~HEREDOC
        <h3 class="collapsible">
          <a class="js-collapsible" data-collapsible-id=#{id}>
            Initialize your dependencies
          </a>
        </h3>

        <div id="#{id}" class="collapsible-content" style="display: none;">
          <p>Create a file named <code>#{config['file_name']}</code> and add the following code:</p>
          <pre class="highlight bash"><code>#{highlighted_client_source}</code></pre>
        </div>
      HEREDOC
      end

      code_html = <<~HEREDOC
        <h2>Write the code</h2>
        <p>Add the following to <code>#{config['file_name']}</code>:</p>
        <pre class="highlight #{lexer.tag}"><code>#{highlighted_code_source}</code></pre>
      HEREDOC

      run_html = generate_run_command(config['run_command'], config['file_name'])

      prereqs = application_html + dependency_html + client_html
      prereqs = "<h2>Prerequisites</h2>#{prereqs}" if prereqs
      prereqs + code_html + run_html
    end
  end

  private

  def highlight(source, lexer)
    formatter = Rouge::Formatters::HTML.new
    formatter.format(lexer.lex(source))
  end

  def language_to_lexer_name(language)
    if language_configuration['languages'][language]
      language_configuration['languages'][language]['lexer']
    else
      language
    end
  end

  def language_to_lexer(language)
    language = language_to_lexer_name(language)
    return Rouge::Lexers::PHP.new({ start_inline: true }) if language == 'php'
    Rouge::Lexer.find(language.downcase) || Rouge::Lexer.find('text')
  end

  def language_configuration
    @language_configuration ||= YAML.load_file("#{Rails.root}/config/code_languages.yml")
  end

  def generate_code_block(language, input, unindent)
      filename = "#{Rails.root}/#{input['source']}"
      if input
          raise "BuildingBlockFilter - Could not load #{filename} for language #{language}" unless File.exist?(filename)

          code = File.read(filename)
          lexer = language_to_lexer(language)

          total_lines = code.lines.count

          # Minus one since lines are not zero-indexed
          from_line = (input['from_line'] || 1) - 1
          to_line = (input['to_line'] || total_lines) - 1

          code = code.lines[from_line..to_line].join
          code.unindent! if unindent

          highlight(code, lexer)
      end
  end

  def generate_dependencies(language, dependencies)
      dep_managers = {
          "javascript" => lambda { |deps| "$ npm install #{dependencies.join(' ')}" },
          "csharp" => lambda { |deps| "$ Install-Package #{dependencies.join(' ')}" },
          "php" => lambda { |deps| "$ composer require #{dependencies.join(' ')}" },
          "python" => lambda { |deps| "$ pip install #{dependencies.join(' ')}" },
          "ruby" => lambda { |deps| "$ gem install #{dependencies.join(' ')}" },
          "java" => lambda { |deps| 
              {

                'text' => 'Add the following to <code>build.gradle</code>:',
                'code' => dependencies.map { |d| "compile '#{d}'" }.join("<br />")
              }
          },
      }

      deps = dep_managers[language].call(dependencies)
      deps = {'code' => deps} unless deps['code']
      deps['text'] = '' unless deps['text']

      id = SecureRandom.hex

      <<~HEREDOC
        <h3 class="collapsible">
          <a class="js-collapsible" data-collapsible-id=#{id}>
            Install dependencies
          </a>
        </h3>

        <div id="#{id}" class="collapsible-content" style="display: none;">
          <p>#{deps['text']}</p>
          <pre class="highlight bash"><code>#{deps['code']}</code></pre>
        </div>
      HEREDOC
  end

    def generate_run_command(command, filename)
      return '' unless command
      if command == 'java-ide'
          command = <<~HEREDOC
## Run your code
We can use the `application` plugin for Gradle to simplify the running of our application.

Update your `build.gradle` with the following:

```groovy
apply plugin: 'application'
mainClassName = project.hasProperty('main') ? project.getProperty('main') : ''
```

Run the following command to execute your application replacing `com.nexmo.quickstart.voice` with the package containing `#{filename.gsub(".java", "")}`:

```sh
gradle run -Pmain=com.nexmo.quickstart.voice.#{filename.gsub(".java","")}
```
HEREDOC
      else
      command = <<~HEREDOC
        ## Run your code

        Save this file to your machine and run it:

        <pre class="highlight bash"><code>$ #{command}</code></pre>

      HEREDOC
      end

      command
    end

    def generate_application_block(app)
        return '' unless app
        app['name'] = 'ExampleVoiceProject' unless app['name']

        base_url = 'http://demo.ngrok.io' 
        base_url = 'https://example.com' if app['disable_ngrok']

        app['event_url'] = "#{base_url}/webhooks/events" unless app['event_url']
        app['answer_url'] = "#{base_url}/webhooks/answer" unless app['answer_url']

        ngrok_note = ''
        unless app['disable_ngrok']
            ngrok_note = <<~HEREDOC
            <p>Nexmo needs to connect to your local machine to access your <code>answer_url</code>. We recommend using <a href="https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/">ngrok</a> to do this. Make sure to change <code>demo.ngrok.io</code> in the examples below to your own ngrok URL.</p>
            HEREDOC
        end

        content = <<~HEREDOC
          <p>A Nexmo application contains the required configuration for your project. You can create an application using the <a href="https://github.com/Nexmo/nexmo-cli">Nexmo CLI</a> (see below) or <a href="https://dashboard.nexmo.com/voice/create-application">via the dashboard</a>. To learn more about applications <a href="/concepts/guides/applications">see our Nexmo concepts guide</a>.</p>
          <h4>Install the CLI</h4>
          <pre class="highlight bash"><code>$ npm install -g nexmo-cli</code></pre>

          <h4>Create an application</h4>
          <p>Once you have the CLI installed you can use it to create a Nexmo application. Run the following command and make a note of the application ID that it returns. This is the value to use in <code>NEXMO_APPLICATION_ID</code> in the example below. It will also create <code>private.key</code> in the current directory which you will need in the <em>Initialize your dependencies</em> step</p>
          #{ngrok_note}
          <pre class="highlight sh"><code>$ nexmo app:create "#{app['name']}" #{app['answer_url']} #{app['event_url']} --keyfile private.key</code></pre>
        HEREDOC

        # It doesn't make sense to create an application in some blocks
        # e.g. download a recording
        if app['use_existing']
            content = <<~HEREDOC
            <p>#{app['use_existing']}</p>
            HEREDOC
        end

        id = SecureRandom.hex
        <<~HEREDOC
        <h3 class="collapsible">
          <a class="js-collapsible" data-collapsible-id=#{id}>
            #{app['use_existing'] ? 'Use your existing application' : 'Create an application'}
          </a>
        </h3>

        <div id="#{id}" class="collapsible-content" style="display: none;">
        #{content}
        </div>
        HEREDOC
    end
end
