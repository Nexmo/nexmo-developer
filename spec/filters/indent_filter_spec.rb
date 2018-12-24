require 'rails_helper'

RSpec.describe IndentFilter do 
    it 'turns four whitespaces followed by "->" into indented text' do
        input = "    -> a"

        expected_output = "<div class=\"indent\"> <p>a</p></div>"

        expect(described_class.call(input)).to eq(expected_output)
    end
end