require 'rails_helper'

RSpec.describe TechioFilter do
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

  it 'returns matching input formatted with HTML and JS script tags' do
    input = <<~HEREDOC
      ```techio
      path: /here/is/a/path
      title: this is a title
      ```
    HEREDOC

    expected_output = "FREEZESTARTPGRpdiBjbGFzcz0idGVjaGlvLWNvbnRhaW5lciI-CiAgPGlmcmFtZSB3aWR0aD0iMTAwJSIgZnJhbWVib3JkZXI9IjAiIHNjcm9sbGluZz0ibm8iIGFsbG93dHJhbnNwYXJlbmN5PSJ0cnVlIiBzdHlsZT0idmlzaWJpbGl0eTogaGlkZGVuIiBzcmM9Imh0dHBzOi8vdGVjaC5pby9wbGF5Z3JvdW5kLXdpZGdldC9oZXJlL2lzL2EvcGF0aC90aGlzIGlzIGEgdGl0bGUiPjwvaWZyYW1lPgogIDxzY3JpcHQ-aWYodHlwZW9mIHdpbmRvdy50ZWNoaW9TY3JpcHRJbmplY3RlZD09PSJ1bmRlZmluZWQiKXt3aW5kb3cudGVjaGlvU2NyaXB0SW5qZWN0ZWQ9dHJ1ZTt2YXIgZD1kb2N1bWVudCxzPWQuY3JlYXRlRWxlbWVudCgic2NyaXB0Iik7cy5zcmM9Imh0dHBzOi8vZmlsZXMuY29kaW5nYW1lLmNvbS9jb2RpbmdhbWUvaWZyYW1lLXYtMS00LmpzIjsoZC5oZWFkfHxkLmJvZHkpLmFwcGVuZENoaWxkKHMpO308L3NjcmlwdD4KPC9kaXY-Cg==FREEZEEND\n"

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns NoMethodError if input is formatted correctly but empty' do
    input = <<~HEREDOC
      ```techio
      ```
    HEREDOC

    expect { described_class.call(input) }.to raise_error(NoMethodError)
  end

  it 'returns HTML and JS script tags with no title in the iframe src path if title is missing' do
    input = <<~HEREDOC
      ```techio
      path: /here/is/a/path
      title:
      ```
    HEREDOC

    expected_output = "FREEZESTARTPGRpdiBjbGFzcz0idGVjaGlvLWNvbnRhaW5lciI-CiAgPGlmcmFtZSB3aWR0aD0iMTAwJSIgZnJhbWVib3JkZXI9IjAiIHNjcm9sbGluZz0ibm8iIGFsbG93dHJhbnNwYXJlbmN5PSJ0cnVlIiBzdHlsZT0idmlzaWJpbGl0eTogaGlkZGVuIiBzcmM9Imh0dHBzOi8vdGVjaC5pby9wbGF5Z3JvdW5kLXdpZGdldC9oZXJlL2lzL2EvcGF0aC8iPjwvaWZyYW1lPgogIDxzY3JpcHQ-aWYodHlwZW9mIHdpbmRvdy50ZWNoaW9TY3JpcHRJbmplY3RlZD09PSJ1bmRlZmluZWQiKXt3aW5kb3cudGVjaGlvU2NyaXB0SW5qZWN0ZWQ9dHJ1ZTt2YXIgZD1kb2N1bWVudCxzPWQuY3JlYXRlRWxlbWVudCgic2NyaXB0Iik7cy5zcmM9Imh0dHBzOi8vZmlsZXMuY29kaW5nYW1lLmNvbS9jb2RpbmdhbWUvaWZyYW1lLXYtMS00LmpzIjsoZC5oZWFkfHxkLmJvZHkpLmFwcGVuZENoaWxkKHMpO308L3NjcmlwdD4KPC9kaXY-Cg==FREEZEEND\n"

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns HTML and JS script tags with no path in the iframe src if path is missing' do
    input = <<~HEREDOC
      ```techio
      path:
      title: this is a title
      ```
    HEREDOC

    expected_output = "FREEZESTARTPGRpdiBjbGFzcz0idGVjaGlvLWNvbnRhaW5lciI-CiAgPGlmcmFtZSB3aWR0aD0iMTAwJSIgZnJhbWVib3JkZXI9IjAiIHNjcm9sbGluZz0ibm8iIGFsbG93dHJhbnNwYXJlbmN5PSJ0cnVlIiBzdHlsZT0idmlzaWJpbGl0eTogaGlkZGVuIiBzcmM9Imh0dHBzOi8vdGVjaC5pby9wbGF5Z3JvdW5kLXdpZGdldC90aGlzIGlzIGEgdGl0bGUiPjwvaWZyYW1lPgogIDxzY3JpcHQ-aWYodHlwZW9mIHdpbmRvdy50ZWNoaW9TY3JpcHRJbmplY3RlZD09PSJ1bmRlZmluZWQiKXt3aW5kb3cudGVjaGlvU2NyaXB0SW5qZWN0ZWQ9dHJ1ZTt2YXIgZD1kb2N1bWVudCxzPWQuY3JlYXRlRWxlbWVudCgic2NyaXB0Iik7cy5zcmM9Imh0dHBzOi8vZmlsZXMuY29kaW5nYW1lLmNvbS9jb2RpbmdhbWUvaWZyYW1lLXYtMS00LmpzIjsoZC5oZWFkfHxkLmJvZHkpLmFwcGVuZENoaWxkKHMpO308L3NjcmlwdD4KPC9kaXY-Cg==FREEZEEND\n"

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'returns HTML and JS script tags with no title in the iframe src path if title is completely missing' do
    input = <<~HEREDOC
      ```techio
      path: /here/is/a/path
      ```
    HEREDOC

    expected_output = "FREEZESTARTPGRpdiBjbGFzcz0idGVjaGlvLWNvbnRhaW5lciI-CiAgPGlmcmFtZSB3aWR0aD0iMTAwJSIgZnJhbWVib3JkZXI9IjAiIHNjcm9sbGluZz0ibm8iIGFsbG93dHJhbnNwYXJlbmN5PSJ0cnVlIiBzdHlsZT0idmlzaWJpbGl0eTogaGlkZGVuIiBzcmM9Imh0dHBzOi8vdGVjaC5pby9wbGF5Z3JvdW5kLXdpZGdldC9oZXJlL2lzL2EvcGF0aC8iPjwvaWZyYW1lPgogIDxzY3JpcHQ-aWYodHlwZW9mIHdpbmRvdy50ZWNoaW9TY3JpcHRJbmplY3RlZD09PSJ1bmRlZmluZWQiKXt3aW5kb3cudGVjaGlvU2NyaXB0SW5qZWN0ZWQ9dHJ1ZTt2YXIgZD1kb2N1bWVudCxzPWQuY3JlYXRlRWxlbWVudCgic2NyaXB0Iik7cy5zcmM9Imh0dHBzOi8vZmlsZXMuY29kaW5nYW1lLmNvbS9jb2RpbmdhbWUvaWZyYW1lLXYtMS00LmpzIjsoZC5oZWFkfHxkLmJvZHkpLmFwcGVuZENoaWxkKHMpO308L3NjcmlwdD4KPC9kaXY-Cg==FREEZEEND\n"

    expect(described_class.call(input)).to eq(expected_output)
  end
end
