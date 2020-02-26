require 'rails_helper'

RSpec.describe PhpInlinerFilter do
  it 'adds "?start_inline=1" to regex matching input' do
    input = <<~HEREDOC
      ```php
      $var = 'Hello World!'
      ```
    HEREDOC

    expected_output = <<~HEREDOC
      ```php?start_inline=1
      $var = 'Hello World!'
      ```
    HEREDOC

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'does not add "?start_inline=1" to input that does not match regex' do
    input = <<~HEREDOC
      ```ruby
      var = 'Hello World!'
      ```
    HEREDOC

    expected_output = <<~HEREDOC
      ```ruby
      var = 'Hello World!'
      ```
    HEREDOC

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'does nothing to whitespace input' do
    input = ' '

    expected_output = ' '

    expect(described_class.call(input)).to eql(expected_output)
  end
end
