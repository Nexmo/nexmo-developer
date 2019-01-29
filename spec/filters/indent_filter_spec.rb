require 'rails_helper'

RSpec.describe IndentFilter do
  it 'turns four whitespaces followed by "->" into indented text' do
    input = '    -> a'

    expected_output = "<div class=\"indent\">\n  <p>a</p>\n</div>\n"

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns unaltered less than four whitespaces followed by "->"' do
    input = '   -> a'

    expected_output = '   -> a'

    expect(described_class.call(input)).to eq(expected_output)
  end
end
