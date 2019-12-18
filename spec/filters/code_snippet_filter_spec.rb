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
end