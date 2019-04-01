require 'rails_helper'

RSpec.describe LabelFilter do
  it 'does not transform a random string' do
    input = 'some text'

    expected_output = 'some text'

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'does not alter random text inside brackets' do
    input = '[some text]'

    expect(described_class.call(input)).to eq(input)
  end

  it 'does not transform a matching string if it is not inside brackets' do
    input = 'POST'

    expected_output = 'POST'

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'converts [POST] to a green label' do
    input = '[POST]'

    expected_output = "<span class='Vlt-badge Vlt-badge--green'>POST</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'converts [GET] to a blue label' do
    input = '[GET]'

    expected_output = "<span class='Vlt-badge Vlt-badge--blue'>GET</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'converts [DELETE] to a red label' do
    input = '[DELETE]'

    expected_output = "<span class='Vlt-badge Vlt-badge--red'>DELETE</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'converts [PUT] to a yellow label' do
    input = '[PUT]'

    expected_output = "<span class='Vlt-badge Vlt-badge--yellow'>PUT</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'converts [OPTIONS] to a grey label' do
    input = '[OPTIONS]'

    expected_output = "<span class='Vlt-badge Vlt-badge--grey'>OPTIONS</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns a non-color HTML span tag with  "post" in between the tags when "[post]" is provided' do
    input = '[post]'

    expected_output = "<span class='Vlt-badge '>post</span> "

    expect(described_class.call(input)).to eq(expected_output)
  end
end
