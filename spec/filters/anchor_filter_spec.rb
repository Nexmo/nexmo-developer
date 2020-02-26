require 'rails_helper'

RSpec.describe AnchorFilter do
  it 'turns explicit anchor links into anchor tag' do
    input = <<~HEREDOC
      ⚓️ This is a test
    HEREDOC

    expected_output = <<~HEREDOC
      <a name="this-is-a-test"></a>
    HEREDOC

    expect(described_class.call(input)).to eq(expected_output)
  end
  it 'returns input if input already is an explicit anchor link' do
    input = <<~HEREDOC
      ⚓️ this-is-a-test
    HEREDOC

    expected_output = <<~HEREDOC
      <a name="this-is-a-test"></a>
    HEREDOC

    expect(described_class.call(input)).to eq(expected_output)
  end
end
