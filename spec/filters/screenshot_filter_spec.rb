require 'rails_helper'

RSpec.describe ScreenshotFilter do
  it 'renders image markdown if image location is present in input' do
    input = <<~HEREDOC
      ```screenshot
      image: /a/path/to/an/image.png
      ```
    HEREDOC

    expected_output = '![Screenshot](/a/path/to/an/image.png)'

    # .chop to remove trailing \n from input
    expect(described_class.call(input.chop)).to eq(expected_output)
  end

  it 'raises a NoMethodError if no options are provided' do
    input = <<~HEREDOC
      ```screenshot

      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error(NoMethodError)
  end

  it 'provides instructions if image location is missing' do
    input = <<~HEREDOC
      ```screenshot
      image:
      ```
    HEREDOC

    expected_output = <<~HEREDOC
      ## Missing image
      To fix this run:
      ```
      $ rake screenshots:update
      ```
    HEREDOC
    # .chop to remove trailing \n from input
    expect(described_class.call(input.chop)).to eql(expected_output)
  end
end
