require 'rails_helper'

RSpec.describe CodeSnippetFilter do
  let(:example_source_file) do
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
    expect(File).to receive(:read).with(/code_only/).once.and_call_original

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
    expect(File).to receive(:read).with(/write_code/).once.and_call_original

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
    expect(File).to receive(:read).with(/write_code/).once.and_call_original
    expect(File).to receive(:read).with(/_application_voice/).once.and_call_original
    expect(File).to receive(:read).with(/_dependencies/).once.and_call_original
    expect(File).to receive(:read).with(/_configure_client/).once.and_call_original

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
    expect(File).to receive(:read).with(/write_code/).once.and_call_original
    expect(File).to receive(:read).with(/_application_voice/).once.and_call_original

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
