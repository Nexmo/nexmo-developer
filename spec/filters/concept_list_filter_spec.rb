require 'rails_helper'

RSpec.describe ConceptListFilter do
  it 'raises an exception when invalid YAML is provided' do
    input = <<~HEREDOC
      ```concept_list
      ```
    HEREDOC
    expect { described_class.call(input) }.to raise_error(RuntimeError, 'concept_list filter takes a YAML config')
  end

  it 'raises an exception when the required YAML fields are missing' do
    input = <<~HEREDOC
      ```concept_list
      foo: bar
      ```
    HEREDOC
    expect { described_class.call(input) }.to raise_error(RuntimeError, "concept_list filter requires 'product' or 'concepts' key")
  end

  it 'renders 0 products returned as an unordered list' do
    allow(Concept).to receive(:all).and_return([])

    input = <<~HEREDOC
      ```concept_list
      product: messaging/sms
      ```
    HEREDOC

    output = described_class.call(input)

    expected_output = ''

    expect(output).to eq(expected_output)
  end

  it 'renders 1 product returned as an unordered list' do
    allow(Concept).to receive(:all).and_return([first_mock_concept])

    input = <<~HEREDOC
      ```concept_list
      product: messaging/sms
      ```
    HEREDOC

    output = described_class.call(input)

    expected_output = "FREEZESTARTPHVsIGNsYXNzPSJWbHQtbGlzdCBWbHQtbGlzdC0tc2ltcGxlIj4KICAKICAgIDxsaT48YSBocmVmPSIvcGF0aC90by90ZXN0LWNvbmNlcHQiPlRlc3QgQ29uY2VwdDwvYT46IFRoaXMgaXMgYSBkZW1vIGNvbmNlcHQ8L3A-PC9saT4KICAKPC91bD4KFREEZEEND\n"

    expect(output).to eq(expected_output)
  end

  it 'renders 2 products returned as an unordered list' do
    allow(Concept).to receive(:all).and_return([first_mock_concept, second_mock_concept])

    input = <<~HEREDOC
      ```concept_list
      product: messaging/sms
      ```
    HEREDOC

    output = described_class.call(input)

    expected_output = "FREEZESTARTPHVsIGNsYXNzPSJWbHQtbGlzdCBWbHQtbGlzdC0tc2ltcGxlIj4KICAKICAgIDxsaT48YSBocmVmPSIvcGF0aC90by90ZXN0LWNvbmNlcHQiPlRlc3QgQ29uY2VwdDwvYT46IFRoaXMgaXMgYSBkZW1vIGNvbmNlcHQ8L3A-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSIvcGF0aC90by9zZWNvbmQtY29uY2VwdCI-QW5vdGhlciBDb25jZXB0PC9hPjogVGhpcyBpcyBhIHNlY29uZCBkZW1vIGNvbmNlcHQ8L3A-PC9saT4KICAKPC91bD4KFREEZEEND\n"

    expect(output).to eq(expected_output)
  end

  it 'respects ignore_in_list' do
    allow(Concept).to receive(:all).and_return([first_mock_concept, ignore_in_list_concept])

    input = <<~HEREDOC
      ```concept_list
      product: messaging/sms
      ```
    HEREDOC

    output = described_class.call(input)

    expected_output = "FREEZESTARTPHVsIGNsYXNzPSJWbHQtbGlzdCBWbHQtbGlzdC0tc2ltcGxlIj4KICAKICAgIDxsaT48YSBocmVmPSIvcGF0aC90by90ZXN0LWNvbmNlcHQiPlRlc3QgQ29uY2VwdDwvYT46IFRoaXMgaXMgYSBkZW1vIGNvbmNlcHQ8L3A-PC9saT4KICAKPC91bD4KFREEZEEND\n"

    expect(output).to eq(expected_output)
  end

  it 'returns an empty string if only concepts with ignore_in_list are returned' do
    allow(Concept).to receive(:all).and_return([ignore_in_list_concept])

    input = <<~HEREDOC
      ```concept_list
      product: messaging/sms
      ```
    HEREDOC

    output = described_class.call(input)

    expected_output = ''

    expect(output).to eq(expected_output)
  end

  it 'returns all matching keys when provided via concepts' do
    allow(Concept).to receive(:all).and_return([first_mock_concept, second_mock_concept])
    input = <<~HEREDOC
      ```concept_list
      concepts:
        - messaging/sms/test-concept
        - messaging/sms/second-concept
      ```
    HEREDOC

    output = described_class.call(input)

    expected_output = "FREEZESTARTPHVsIGNsYXNzPSJWbHQtbGlzdCBWbHQtbGlzdC0tc2ltcGxlIj4KICAKICAgIDxsaT48YSBocmVmPSIvcGF0aC90by90ZXN0LWNvbmNlcHQiPlRlc3QgQ29uY2VwdDwvYT46IFRoaXMgaXMgYSBkZW1vIGNvbmNlcHQ8L3A-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSIvcGF0aC90by9zZWNvbmQtY29uY2VwdCI-QW5vdGhlciBDb25jZXB0PC9hPjogVGhpcyBpcyBhIHNlY29uZCBkZW1vIGNvbmNlcHQ8L3A-PC9saT4KICAKPC91bD4KFREEZEEND\n"

    expect(output).to eq(expected_output)
  end

  it 'ignores any matching concepts that are not provided in the concepts key' do
    allow(Concept).to receive(:all).and_return([first_mock_concept, second_mock_concept])
    input = <<~HEREDOC
      ```concept_list
      concepts:
        - messaging/sms/test-concept
      ```
    HEREDOC

    output = described_class.call(input)

    expected_output = "FREEZESTARTPHVsIGNsYXNzPSJWbHQtbGlzdCBWbHQtbGlzdC0tc2ltcGxlIj4KICAKICAgIDxsaT48YSBocmVmPSIvcGF0aC90by90ZXN0LWNvbmNlcHQiPlRlc3QgQ29uY2VwdDwvYT46IFRoaXMgaXMgYSBkZW1vIGNvbmNlcHQ8L3A-PC9saT4KICAKPC91bD4KFREEZEEND\n"

    expect(output).to eq(expected_output)
  end

  it 'raises an error if concepts that do not exist are provided' do
    allow(Concept).to receive(:all).and_return([])
    input = <<~HEREDOC
      ```concept_list
      concepts:
        - made/up/concept
      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error(RuntimeError, 'Could not find concepts: made/up/concept')
  end

  private

  def first_mock_concept
    Concept.new(
      title: 'Test Concept',
      product: 'messaging/sms',
      description: 'This is a demo concept',
      navigation_weight: 0,
      document_path: '/path/to/test-concept.md',
      url: '/path/to/test-concept',
      ignore_in_list: false
    )
  end

  def second_mock_concept
    Concept.new(
      title: 'Another Concept',
      product: 'messaging/sms',
      description: 'This is a second demo concept',
      navigation_weight: 1,
      document_path: '/path/to/second-concept.md',
      url: '/path/to/second-concept',
      ignore_in_list: false
    )
  end

  def ignore_in_list_concept
    Concept.new(
      title: 'Hidden Concept',
      product: 'messaging/sms',
      description: 'This is a hidden concept',
      navigation_weight: 2,
      document_path: '/path/to/hidden-concept.md',
      url: '/path/to/hidden-concept',
      ignore_in_list: true
    )
  end
end
