require 'rails_helper'

RSpec.describe TutorialsFilter do
  it 'returns an instance of Tutorial with matching input' do
    allow(Tutorial).to receive(:all).and_return([mock_tutorial])

    input = <<~HEREDOC
      ```tutorials
      product: messaging/sms
      ```
    HEREDOC

    output = described_class.call(input)

    expected_output = "FREEZESTARTPHVsIGNsYXNzPSJWbHQtbGlzdCBWbHQtbGlzdC0tc2ltcGxlIj4KICAKICAgIDxsaT48YSBocmVmPSIvcGF0aC90by90ZXN0LXR1dG9yaWFsIj5UZXN0IFR1dG9yaWFsPC9hPjwvbGk-CiAgCjwvdWw-Cg==FREEZEEND\n"

    expect(output).to eq(expected_output)
  end

  it 'raises error if layout specified but cannot be found' do
    input = <<~HEREDOC
      ```tutorials
      product: messaging/sms
      layout: list/json
      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error(Errno::ENOENT)
  end

  it 'raises a NoMethodError if no content is provided' do
    input = <<~HEREDOC
      ```tutorials
      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error(NoMethodError)
  end

  it 'returns encoded string even if product cannot be found' do
    allow(Tutorial).to receive(:all).and_return([mock_tutorial])

    input = <<~HEREDOC
      ```tutorials
      product: not real
      ```
    HEREDOC

    expected_output = "FREEZESTARTPHVsIGNsYXNzPSJWbHQtbGlzdCBWbHQtbGlzdC0tc2ltcGxlIj4KICAKPC91bD4KFREEZEEND\n"

    expect(described_class.call(input)).to eql(expected_output)
  end

    private

  def mock_tutorial
    Tutorial.new(
      title: 'Test Tutorial',
      products: 'messaging/sms',
      description: 'This is a demo tutorial',
      document_path: '/path/to/test-tutorial.md',
      external_link: '/path/to/test-tutorial',
      languages: 'en'
    )
  end
end
