require 'rails_helper'

RSpec.describe InlineEscapeFilter do
  it 'renders a code block when the code is put in between a set of `` characters' do
    input = <<~HEREDOC
      ``console.log(variable)``
    HEREDOC

    expected_output = 'FREEZESTARTPGNvZGU-Y29uc29sZS5sb2codmFyaWFibGUpPC9jb2RlPg==FREEZEEND'

    # using .chop to remove trailing \n in test input string
    expect(described_class.call(input.chop)).to eq(expected_output)
  end

  it 'does not transform the text if it is not put in between a set of `` characters' do
    input = <<~HEREDOC
      console.log(variable)
    HEREDOC

    expected_output = input

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'only transforms inline code and leaves code put on multiple lines unaltered' do
    input = <<~HEREDOC
      ``
      foo.new
      console.log(foo)
      ``
    HEREDOC

    expected_output = input

    expect(described_class.call(input)).to eql(expected_output)
  end
end
