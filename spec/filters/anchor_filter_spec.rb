require 'rails_helper'

RSpec.describe AnchorFilter do
  it 'turns explicit anchor links into anchor tag' do
    input = <<~HEREDOC
      ⚓️ This is a test
    HEREDOC

    expected_output = <<~HEREDOC
      <a name="this-is-a-test"></a>
    HEREDOC

    expect(AnchorFilter.call(input)).to eq(expected_output)
  end
end
