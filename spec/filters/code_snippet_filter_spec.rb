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
  end

  it "returns prereqs + code_html + run_html if config['code_html'] is falsey" do
  end

  it 'populates lexer variable correctly' do
  end

  it 'populates lang variable correctly' do
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

  it "generates highlighted_client_source if config['client']" do
    # mock a generate_code_block call with voice default:
    # filename = "#{Rails.root}/#{input['source']}" <-- stub this file
    # code = File.read(filename) <-- stub this file.read
    # returns formatted code snippets using Rouge <-- test output
  end

  it 'highlighted_client_source raises an exception if file does not exist' do
  end

  it 'highlighted_code_source holds the formatted code snippet' do
  end

  it 'dependency_html is an empty string if there are no dependencies' do
  end

  it 'dependency_html holds ERB data of dependencies with a JWT title if title includes JWT' do
  end

  it 'dependency_html holds ERB data of dependencies with an install dependencies title if JWT is not in title' do
  end

  it 'source_url holds the correct github source path for the code snippet' do
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