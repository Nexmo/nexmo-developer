require 'rails_helper'

RSpec.describe TooltipFilter do
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

  it 'returns unaltered matching but missing details input' do
    input = '^[]()'

    expected_output = '^[]()'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns encoded text with matching input' do
    input = '^[more](Here is a tooltip.)'

    expected_output = 'FREEZESTARTPHNwYW4gY2xhc3M9IlZsdC10b29sdGlwIFZsdC10b29sdGlwLS10b3AiIHRpdGxlPSJIZXJlIGlzIGEgdG9vbHRpcC4iIHRhYmluZGV4PSIwIj4KCW1vcmUmbmJzcDsKCTxzdmcgY2xhc3M9IlZsdC1pY29uIFZsdC1pY29uLS1zbWFsbGVyIFZsdC1pY29uLS10ZXh0LWJvdHRvbSBWbHQtYmx1ZSIgYXJpYS1oaWRkZW49InRydWUiPjx1c2UgeGxpbms6aHJlZj0iL3N5bWJvbC92b2x0YS1pY29ucy5zdmcjVmx0LWljb24taGVscC1uZWdhdGl2ZSIvPjwvc3ZnPgo8L3NwYW4-Cg==FREEZEEND'

    expect(described_class.call(input)).to eql(expected_output)
  end
end
