require 'rails_helper'

RSpec.describe CodeSnippetFilter do
  it 'returns input unaltered if it does not match' do
    input = 'hello'

    expect(described_class.call(input)).to eq('hello')
  end

  it 'returns an error if no input provided' do
    expect { described_class.call }.to raise_error(ArgumentError)  
  end

  it "returns code_html if config['code_html'] is truthy" do
    # snapshot test
  end

  it "returns prereqs + code_html + run_html if config['code_html'] is falsey" do
    # snapshot test
  end

  it 'generates application_html with defaults if no default provided' do
    # base_url = 'http://demo.ngrok.io'
    # app['name'] = 'ExampleProject'
    # app['type'] = 'voice'
    # app['event_url'] = "#{base_url}/webhooks/events"
    # app['answer_url'] = "#{base_url}/webhooks/answer"
    # erb = File.read("#{Rails.root}/app/views/code_snippets/_application_voice.html.erb") <-- stub this file call
    # id = stub SecureRandom.hex
    # what's returned is ERB.new(erb).result(binding)
  end

  it 'generates application_html with values if values provided' do
    # stub values and send it to private method
  end

  it 'raises an exception if language is not known' do
  end

  it 'raises an exception if language file does not exist' do
  end

  it 'raises an exception of application type is not known' do
  end

  it 'dependency_html is an empty string if there are no dependencies' do
  end

  it 'client_html is an empty string if there is no highlighted_client_source' do
  end

  it 'client_html holds client config instructions in ERB format if there is highlighted_client_source' do
  end

  it 'reads code only snippet data if code only is specified' do
  end

  it 'reads write code snippet data if code only is not specified' do
  end
end