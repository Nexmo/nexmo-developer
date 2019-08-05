require 'rails_helper'

RSpec.describe CodeSnippetsFilter do
  it 'returns unaltered input if input is not matching' do
    input = 'hello'

    expect(described_class.call(input)).to eq('hello')
  end

  it 'returns an ArgumentError if no input provided' do
    expect { described_class.call }.to raise_error(ArgumentError)
  end

  it 'creates correct html output with correct input' do
    expect(SecureRandom).to receive(:hex).at_least(:once).and_return('ID123456')
    allow_any_instance_of(CodeSnippetsFilter).to receive(:render_single_snippet).and_return('')

    input = <<~HEREDOC
      ```code_snippets
      source: '_examples/messaging/sms/send-an-sms'
      ```
    HEREDOC

    expect(described_class.call(input)).to match_snapshot('code_snippets_send_sms_default')
  end

  it 'raises an exception if there is no source parameter provided in the input' do
    input = <<~HEREDOC
      ```code_snippets

      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error(RuntimeError, 'A source key must be present in this building_blocks config')
  end

  it 'raises an exception if path in source parameter is non-existent' do
    input = <<~HEREDOC
      ```code_snippets
      source: '_not/an/actual/path'
      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error(RuntimeError, 'No .yml files found for _not/an/actual/path code snippets')
  end
end
