require 'rails_helper'

RSpec.describe TutorialsFilter do
  it 'returns encoded string with proper input' do
    input = <<~HEREDOC
      ```tutorials
      product: messaging/sms
      ```
    HEREDOC

    expected_output = "FREEZESTARTPHVsIGNsYXNzPSJWbHQtbGlzdCBWbHQtbGlzdC0tc2ltcGxlIj4KICAKICAgIDxsaT48YSBocmVmPSIvdHV0b3JpYWxzL3ByaXZhdGUtc21zLWNvbW11bmljYXRpb24iPlByaXZhdGUgU01TIGNvbW11bmljYXRpb248L2E-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSJodHRwczovL3d3dy5uZXhtby5jb20vYmxvZy8yMDE4LzA4LzE0L3NlcnZlcmxlc3Mtc21zLW5leG1vLWlibS1kci8iPlNlcnZlcmxlc3MgU01TIEZvcnR1bmUgQ29va2llcyB3aXRoIE5leG1vIGFuZCBJQk08L2E-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSJodHRwczovL3d3dy5uZXhtby5jb20vYmxvZy8yMDE4LzA2LzI1L3JlY2VpdmluZy1zbXMtZGVsaXZlcnktcmVjZWlwdHMtd2l0aC1waHAtZHIvIj5SZWNlaXZpbmcgU01TIERlbGl2ZXJ5IFJlY2VpcHRzIHdpdGggUEhQPC9hPjwvbGk-CiAgCiAgICA8bGk-PGEgaHJlZj0iaHR0cHM6Ly93d3cubmV4bW8uY29tL2Jsb2cvMjAxNy8xMC8xNi9zZW5kLXNtcy1ydWJ5LW9uLXJhaWxzLWRyLyI-SG93IHRvIFNlbmQgU01TIE1lc3NhZ2VzIHdpdGggUnVieSBvbiBSYWlsczwvYT48L2xpPgogIAogICAgPGxpPjxhIGhyZWY9Ii90dXRvcmlhbHMvdHdvLXdheS1zbXMtZm9yLWN1c3RvbWVyLWVuZ2FnZW1lbnQiPlR3by13YXkgU01TIGZvciBjdXN0b21lciBlbmdhZ2VtZW50PC9hPjwvbGk-CiAgCiAgICA8bGk-PGEgaHJlZj0iaHR0cHM6Ly93d3cubmV4bW8uY29tL2Jsb2cvMjAxNy8wNS8wMy9zZW5kLXNtcy1tZXNzYWdlcy13aXRoLWphdmEtZHIvIj5Ib3cgdG8gU2VuZCBTTVMgTWVzc2FnZXMgd2l0aCBKYXZhPC9hPjwvbGk-CiAgCiAgICA8bGk-PGEgaHJlZj0iaHR0cHM6Ly93d3cubmV4bW8uY29tL2Jsb2cvMjAxNy8wNi8yMi9zZW5kLXNtcy1tZXNzYWdlcy1weXRob24tZmxhc2stZHIvIj5Ib3cgdG8gU2VuZCBTTVMgTWVzc2FnZXMgd2l0aCBQeXRob24sIEZsYXNrIGFuZCBOZXhtbzwvYT48L2xpPgogIAogICAgPGxpPjxhIGhyZWY9Imh0dHBzOi8vd3d3Lm5leG1vLmNvbS9ibG9nLzIwMTgvMDYvMTkvcmVjZWl2aW5nLWFuLXNtcy13aXRoLXBocC1kci8iPlJlY2VpdmluZyBhbiBTTVMgd2l0aCBQSFA8L2E-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSJodHRwczovL3d3dy5uZXhtby5jb20vYmxvZy8yMDE3LzA5LzIwL3NlbmRpbmctc21zLW1lc3NhZ2VzLXdpdGgtcGhwLWRyLyI-U2VuZGluZyBTTVMgTWVzc2FnZXMgd2l0aCBQSFA8L2E-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSJodHRwczovL3d3dy5uZXhtby5jb20vYmxvZy8yMDE3LzEwLzIzL3JlY2VpdmUtc21zLW1lc3NhZ2VzLXJ1Ynktb24tcmFpbHMtZHIvIj5Ib3cgdG8gUmVjZWl2ZSBTTVMgTWVzc2FnZXMgd2l0aCBSdWJ5IG9uIFJhaWxzPC9hPjwvbGk-CiAgCiAgICA8bGk-PGEgaHJlZj0iL3R1dG9yaWFscy9yZWNlaXZpbmctY29uY2F0LXNtcyI-UmVjZWl2aW5nIENvbmNhdGVuYXRlZCBTTVM8L2E-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSJodHRwczovL3d3dy5uZXhtby5jb20vYmxvZy8yMDE3LzAzLzIzL3NlbmQtc21zLW1lc3NhZ2VzLWFzcC1uZXQtbXZjLWZyYW1ld29yay1kci8iPkhvdyB0byBTZW5kIFNNUyBNZXNzYWdlcyB3aXRoIEFTUC5ORVQgTVZDIEZyYW1ld29yazwvYT48L2xpPgogIAogICAgPGxpPjxhIGhyZWY9Ii90dXRvcmlhbHMvbW9iaWxlLWFwcC1pbnZpdGVzIj5Nb2JpbGUgYXBwIGludml0ZXM8L2E-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSJodHRwczovL3d3dy5uZXhtby5jb20vYmxvZy8yMDE4LzA5LzE4L2FueXRoaW5nLXRvLXNtcy1pZnR0dC1uZXhtby1kci8iPkFueXRoaW5nLXRvLVNNUyB3aXRoIElGVFRUIGFuZCBOZXhtbzwvYT48L2xpPgogIAogICAgPGxpPjxhIGhyZWY9Ii90dXRvcmlhbHMvc21zLWN1c3RvbWVyLXN1cHBvcnQiPlNNUyBDdXN0b21lciBTdXBwb3J0PC9hPjwvbGk-CiAgCiAgICA8bGk-PGEgaHJlZj0iaHR0cHM6Ly93d3cubmV4bW8uY29tL2Jsb2cvMjAxOC8wOC8wNy9zbXMtbm90aWZpY2F0aW9ucy1icm93c2VyLXdpdGgtYW5ndWxhci1ub2RlLWFibHktZHIvIj5TaG93IFNNUyBOb3RpZmljYXRpb25zIGluIHRoZSBCcm93c2VyIHdpdGggQW5ndWxhciwgTm9kZS5KUywgYW5kIEFibHk8L2E-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSJodHRwczovL3d3dy5uZXhtby5jb20vYmxvZy8yMDE3LzAzLzMxL3JlY2lldmUtc21zLW1lc3NhZ2VzLXdpdGgtYXNwLW5ldC1tdmMtZnJhbWV3b3JrLWRyLyI-UmVjZWl2ZSBTTVMgTWVzc2FnZXMgd2l0aCBBU1AuTkVUIE1WQyBGcmFtZXdvcms8L2E-PC9saT4KICAKICAgIDxsaT48YSBocmVmPSJodHRwczovL3d3dy5uZXhtby5jb20vYmxvZy8yMDE3LzA3LzIxL2dldC1zbXMtZGVsaXZlcnktcmVjZWlwdC1hc3AtbmV0LW12Yy1kci8iPkhvdyB0byBHZXQgYW4gU01TIERlbGl2ZXJ5IFJlY2VpcHQgaW4gQVNQIC5ORVQgTVZDPC9hPjwvbGk-CiAgCiAgICA8bGk-PGEgaHJlZj0iaHR0cHM6Ly93d3cubmV4bW8uY29tL2Jsb2cvMjAxNy8wNS8zMS9yZWNlaXZlLXNtcy1tZXNzYWdlcy1qYXZhLWRyLyI-UmVjZWl2ZSBTTVMgTWVzc2FnZXMgd2l0aCBKYXZhPC9hPjwvbGk-CiAgCiAgICA8bGk-PGEgaHJlZj0iaHR0cHM6Ly93d3cubmV4bW8uY29tL2Jsb2cvMjAxNy8xMC8xOS9yZWNlaXZlLXNtcy1kZWxpdmVyeS1yZWNlaXB0LXJ1Ynktb24tcmFpbHMtZHIvIj5SZWNlaXZlIGFuIFNNUyBEZWxpdmVyeSBSZWNlaXB0IGZyb20gYSBNb2JpbGUgQ2FycmllciB3aXRoIFJ1Ynkgb24gUmFpbHM8L2E-PC9saT4KICAKPC91bD4KFREEZEEND\n"

    expect(described_class.call(input)).to eql(expected_output)
  end

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
