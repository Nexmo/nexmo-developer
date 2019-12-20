require 'rails_helper'

RSpec.describe CodeSnippetFilter do
  it 'returns input unaltered if it does not match' do
    input = 'hello'

    expect(described_class.call(input)).to eq('hello')
  end

  it 'returns an error if no input provided' do
    expect { described_class.call }.to raise_error(ArgumentError)
  end

  it 'returns code snippet in the code only template if code only parameter is defined as true' do
    allow(File).to receive(:exist?).and_call_original
    expect(File).to receive(:exist?).with(/example_snippet/).and_return(true)
    expect(File).to receive(:read).with(/example_snippet/).and_return(example_source_file)
    expect(File).to receive(:read).with(/code_only/).and_return(code_only_template)

    input = <<~HEREDOC
      ```single_code_snippet
      language: ruby
      title: Ruby
      code:
        source: .repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb
        from_line: 18
        to_line: 32
      unindent: false
      code_only: true
      ```
    HEREDOC

    expect(described_class.call(input)).to match_snapshot('code_snippet_filter/code_only_default')
  end

  it 'returns full code snippet with run instructions and prerequisites if code only parameter is undefined or false' do
    allow(File).to receive(:exist?).and_call_original
    expect(File).to receive(:exist?).with(/example_snippet/).and_return(true)
    expect(File).to receive(:read).with(/example_snippet/).and_return(example_source_file)
    expect(File).to receive(:read).with(/write_code/).and_return(write_code_template)

    input = <<~HEREDOC
      ```single_code_snippet
      language: ruby
      title: Ruby
      code:
        source: .repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb
        from_line: 18
        to_line: 32
      unindent: false
      ```
    HEREDOC

    expect(described_class.call(input)).to match_snapshot('code_snippet_filter/code_snippet_default')
  end

  it 'raises an exception if language is not known' do
    input = <<~HEREDOC
      ```single_code_snippet
      language: klingon
      title: Ruby
      code:
        source: .repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb
        from_line: 18
        to_line: 32
      unindent: false
      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error('Unknown language: klingon')
  end

  it 'raises an exception if language file does not exist' do
    allow(File).to receive(:exist?).and_call_original
    expect(File).to receive(:exist?).with(/example_snippet/).and_return(false)

    input = <<~HEREDOC
      ```single_code_snippet
      language: ruby
      title: Ruby
      code:
        source: .repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb
        from_line: 18
        to_line: 32
      unindent: false
      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error("CodeSnippetFilter - Could not load #{Rails.root}/.repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb for language ruby")
  end

  it 'raises an exception if application is specified but type is not recognized' do
    input = <<~HEREDOC
      ```single_code_snippet
      language: ruby
      title: Ruby
      code:
        source: .repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb
        from_line: 18
        to_line: 32
      application:
        type: 'klingon_warbird'
      unindent: false
      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error("Invalid application type when creating code snippet: 'klingon_warbird'")
  end

  it 'returns code snippet with application and client configuration instructions and dependencies if they are defined' do
    allow(File).to receive(:exist?).and_call_original
    expect(SecureRandom).to receive(:hex).at_least(:once).and_return('ID123456')
    expect(File).to receive(:exist?).with(/example_snippet/).and_return(true).twice
    expect(File).to receive(:read).with(/example_snippet/).and_return(example_source_file).twice
    expect(File).to receive(:read).with(/write_code/).and_return(write_code_template)
    expect(File).to receive(:read).with(/_application_voice/).and_return(voice_template_file)
    expect(File).to receive(:read).with(/_dependencies/).and_return(dependencies_template)
    expect(File).to receive(:read).with(/_configure_client/).and_return(configure_client_template)

    input = <<~HEREDOC
      ```single_code_snippet
      language: ruby
      title: Ruby
      code:
        source: .repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb
        from_line: 18
        to_line: 32
      application:
        type: 'voice'
      client:
        source: .repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb
        from_line: 11
        to_line: 16
      dependencies:
        - 'vulcans'
      unindent: false
      ```
    HEREDOC

    expect(described_class.call(input)).to match_snapshot('code_snippet_filter/code_snippet_with_prereqs_deps_client_application_defined')
  end

  it 'returns default application values if none are specified' do
    allow(File).to receive(:exist?).and_call_original
    expect(File).to receive(:exist?).with(/example_snippet/).and_return(true)
    expect(File).to receive(:read).with(/example_snippet/).and_return(example_source_file)
    expect(File).to receive(:read).with(/write_code/).and_return(write_code_template)
    expect(File).to receive(:read).with(/_application_voice/).and_return(voice_template_file)

    input = <<~HEREDOC
      ```single_code_snippet
      language: ruby
      title: Ruby
      code:
        source: .repos/nexmo/nexmo-ruby-code-snippets/example/example_snippet.rb
        from_line: 18
        to_line: 32
      application:
        name:
      unindent: false
      ```
    HEREDOC

    expected_app_name = 'ExampleProject'
    expected_base_url = 'http://demo.ngrok.io'
    expected_events_url = "#{expected_base_url}/webhooks/events"
    expected_answer_url = "#{expected_base_url}/webhooks/answer"

    output = described_class.call(input)

    expect(output).to include(expected_app_name)
    expect(output).to include(expected_base_url)
    expect(output).to include(expected_events_url)
    expect(output).to include(expected_answer_url)
  end
end

def example_source_file
  <<~HEREDOC
    require 'dotenv/load'
    require 'nexmo'

    NEXMO_API_KEY = ENV['NEXMO_API_KEY']
    NEXMO_API_SECRET = ENV['NEXMO_API_SECRET']
    NEXMO_APPLICATION_ID = ENV['NEXMO_APPLICATION_ID']
    NEXMO_APPLICATION_PRIVATE_KEY_PATH = ENV['NEXMO_APPLICATION_PRIVATE_KEY_PATH']
    NEXMO_NUMBER = ENV['NEXMO_NUMBER']
    TO_NUMBER = ENV['TO_NUMBER']

    client = Nexmo::Client.new(
      api_key: NEXMO_API_KEY,
      api_secret: NEXMO_API_SECRET,
      application_id: NEXMO_APPLICATION_ID,
      private_key: File.read(NEXMO_APPLICATION_PRIVATE_KEY_PATH)
    )

    response = client.calls.create(
      to: [{
        type: 'phone',
        number: TO_NUMBER
      }],
      from: {
        type: 'phone',
        number: NEXMO_NUMBER
      },
      answer_url: [
        'https://developer.nexmo.com/ncco/tts.json'
      ]
    )

    puts response.inspect
  HEREDOC
end

def code_only_template
  <<~HEREDOC
    <div class="copy-wrapper">
      <div class="copy-button" data-lang="<%= lang %>" data-block="<%= config['source'] %>" data-section="code">
        <%= octicon "clippy", :class => 'top left' %> <span><%= I18n.t('.copy-to-clipboad') %></span>
      </div>
      <pre class="highlight <%= lexer.tag %> main-code"><code><%= highlighted_code_source %></code></pre>
    </div>
  HEREDOC
end

def write_code_template
  <<~HEREDOC
    <h2 class="Vlt-title--margin-top3"><%= I18n.t('.code_snippets.write_code.write_the_code') %></h2>
    <%= add_instructions %>

    <div class="copy-wrapper">
      <div class="copy-button" data-lang="<%= lang %>" data-block="<%= config['source'] %>" data-section="code">
        <%= octicon "clippy", :class => 'top left' %> <span><%= I18n.t('.code_snippets.copy_to_clipboard') %></span>
      </div>
      <pre class="highlight <%= lexer.tag %> main-code"><code><%= highlighted_code_source %></code></pre>

    </div>

    <p><a data-section="code" data-lang="<%= lang %>" data-block="<%= config['source'] %>" href="<%= source_url %>"><%= I18n.t('.code_snippets.write_code.view_full_source') %></a></p>
  HEREDOC
end

def voice_template_file
  <<~HEREDOC
    <div class="Vlt-box Vlt-box--lesspadding Nxd-accordion-emphasis">
    <h5 class="Vlt-js-accordion__trigger Vlt-accordion__trigger" data-accordion="acc<%= id %>" tabindex="0">
        <%= app['use_existing'] ? I18n.t('.code_snippets.use_your_app') : I18n.t('.code_snippets.create_an_app') %>
    </h5>

    <div id="acc<%=id %>"  class="Vlt-js-accordion__content Vlt-accordion__content Vlt-accordion__content--noborder">
        <% if app['use_existing'] %>
            <p><%= app['use_existing'] %></p>
        <% else %>
            <p><%= I18n.t('.code_snippets.nexmo_application_contains_html') %></p>
            <h4><%= I18n.t('.code_snippets.install_the_cli') %></h4>
            <pre class="highlight bash dependencies"><code>npm install -g nexmo-cli</code></pre>

            <h4><%= I18n.t('.code_snippets.create_an_app') %></h4>
            <p><%= I18n.t('.code_snippets.once_you_have_the_cli_installed_html') %></p>

            <% unless app['disable_ngrok'] %>
              <p><%= I18n.t('.code_snippets.nexmo_needs_to_connect_html') %></p>
            <% end %>

            <pre class="highlight bash dependencies"><code>nexmo app:create "<%=app['name'] %>" <%=app['answer_url'] %> <%=app['event_url'] %> --keyfile private.key</code></pre>
        <% end %>
      </div>
    </div>
  HEREDOC
end

def dependencies_template
  <<~HEREDOC
    <div class="Vlt-box Vlt-box--lesspadding Nxd-accordion-emphasis">
    <h5 class="Vlt-js-accordion__trigger Vlt-accordion__trigger" data-accordion="acc<%= id %>" tabindex="0"><%= title %></h5>

    <div id="acc<%= id %>" class="Vlt-js-accordion__content Vlt-accordion__content Vlt-accordion__content--noborder">
          <p><%=deps['text']%></p>
          <% if deps['code'] %>
          <pre class="highlight <%= deps['type'] || 'bash' %> dependencies"><code><%=deps['code']%></code></pre>
          <% end %>
      </div>
    </div>
  HEREDOC
end

def configure_client_template
  <<~HEREDOC
    <div class="Vlt-box Vlt-box--lesspadding Nxd-accordion-emphasis">
    <h5 class="Vlt-js-accordion__trigger Vlt-accordion__trigger" data-accordion="acc<%= id %>" tabindex="0">
            <%= I18n.t('.code_snippets.configure_client.initialize_dependencies') %>
    </h5>

    <div id="acc<%=id %>"  class="Vlt-js-accordion__content Vlt-accordion__content Vlt-accordion__content--noborder">
      <%= create_instructions %>
      <div class="copy-wrapper">

        <div class="copy-button" data-lang="<%= lang %>" data-block="<%= config['source'] %>" data-section="configure">
          <%= octicon "clippy", :class => 'top left' %> <span>Copy to Clipboard</span>
        </div>
        <pre class="highlight copy-to-clipboard <%= config['title'] %>"><code><%= highlighted_client_source %></code></pre>
      </div>

      <p><a data-section="configure" data-lang="<%= lang %>" data-block="<%= config['source'] %>" href="<%= client_url %>">View full source</a></p>

      </div>
    </div>
  HEREDOC
end
