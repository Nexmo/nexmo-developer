require 'rails_helper'

RSpec.describe LabelFilter do
  it 'does not transform a random string' do
    input = 'some text'

    expected_output = 'some text'

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns an HTML span tag when provided with random text inside brackets' do
    input = '[some text]'

    expected_output = "<span class='Vlt-badge '>some text</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'does not transform a matching string if it is not inside brackets' do
    input = 'POST'

    expected_output = 'POST'

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns a green HTML class when string "[POST]" is provided and puts "POST" in between <span> tags stripped of brackets' do
    input = '[POST]'

    expected_output = "<span class='Vlt-badge Vlt-badge--green'>POST</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns a blue HTML class when string "[GET]" is provided and puts "GET" in between <span> tags stripped of brackets' do
    input = '[GET]'

    expected_output = "<span class='Vlt-badge Vlt-badge--blue'>GET</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns a red HTML class when string "[DELETE]" is provided and puts "DELETE" in between <span> tags stripped of brackets' do
    input = '[DELETE]'

    expected_output = "<span class='Vlt-badge Vlt-badge--red'>DELETE</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns a yellow HTML class when string "[PUT]" is provided and puts "PUT" in between <span> tags stripped of brackets' do
    input = '[PUT]'

    expected_output = "<span class='Vlt-badge Vlt-badge--yellow'>PUT</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  # possible undesired behavior to be discussed
  it 'returns a non-color HTML span tag with  "post" in between the tags when "[post]" is provided' do
    input = '[post]'

    expected_output = "<span class='Vlt-badge '>post</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end
end
