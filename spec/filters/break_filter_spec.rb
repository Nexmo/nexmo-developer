require 'rails_helper'

RSpec.describe BreakFilter do
  it 'turns § symbol into a break HTML tag' do
    input = <<~HEREDOC
      §
    HEREDOC

    expected_output = <<~HEREDOC
      <br>
    HEREDOC

    expect(described_class.call(input)).to eq(expected_output)
  end
  it 'turns more than one instance of § into an equal number of break HTML tags' do
    input = <<~HEREDOC
      §§
    HEREDOC

    expected_output = <<~HEREDOC
      <br><br>
    HEREDOC

    expect(described_class.call(input)). to eq(expected_output)
  end
  it 'only transforms the § symbol and does not turn anything else into a break HTML tag' do
    input = <<~HEREDOC
      not a symbol
    HEREDOC

    expected_output = <<~HEREDOC
      not a symbol
    HEREDOC

    expect(described_class.call(input)). to eq(expected_output)
  end
end
