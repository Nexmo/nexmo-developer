require 'rails_helper'

RSpec.describe UnfreezeFilter do
  it 'returns whitespace with whitespace input' do
    input = ' '

    expected_output = ' '

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns unaltered non-matching input' do
    input = 'some text'

    expected_output = 'some text'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns whitespace with input: FREEZESTARTFREEZEEND' do
    input = 'FREEZESTARTFREEZEEND'

    expected_output = ''

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns text stripped of <p> tag with input: <p>FREEZESTART' do
    input = '<p>FREEZESTART'

    expected_output = 'FREEZESTART'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns text stripped of </p> tag with input: FREEZEEND</p>' do
    input = 'FREEZEEND</p>'

    expected_output = 'FREEZEEND'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'raises an ArgumentError if there is invalid input' do
    input = 'FREEZESTART()FREEZEEND'

    expect { described_class.call(input) }.to raise_error(ArgumentError, 'invalid base64')
  end

  it 'decodes valid Base64 encoded string' do
    input = 'FREEZESTARTPGRpdiBjbGFzcz0icm93Ij4=FREEZEEND'

    expected_output = '<div class="row">'

    expect(described_class.call(input)).to eql(expected_output)
  end
end
