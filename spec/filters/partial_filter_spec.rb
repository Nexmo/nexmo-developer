require 'rails_helper'

RSpec.describe PartialFilter do
  it 'renders input as HTML with config["platform"] set to true' do
    allow(File).to receive(:read).and_return(mock_partial)

    input = <<~HEREDOC
      ```partial
      source: _some_path/to/a/file.md
      platform: true
      ```
    HEREDOC

    expected_output = "<div class=\"js-platform\" data-platform=\"true\" data-active=\"false\">\n  <p> # Call Convenience methods for Stitch and JavaScript\nSome content here</p>\n</div>\n\n"
    

    # .chop trailing \n from output
    expect(described_class.call(input.chop)).to eql(expected_output.chop)
  end

  it 'renders input as markdown with config["platform"] not included' do
    allow(File).to receive(:read).and_return(mock_partial)

    input = <<~HEREDOC
      ```partial
      source: _some_path/to/a/file.md
      ```
    HEREDOC

    expected_output = "---\ntitle: JavaScript\nlanguage: javascript\n---\n # Call Convenience methods for Stitch and JavaScript\nSome content here\n"

    expect(described_class.call(input.chop)).to eql(expected_output)
  end

  it 'returns whitespace with whitespace input' do
    input = ' '

    expected_output = ' '

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns unaltered incorrect input' do
    input = 'this is incorrect input'

    expected_output = 'this is incorrect input'

    expect(described_class.call(input)).to eql(expected_output)
  end

  private

  def mock_partial
    <<~HEREDOC
      ---
      title: JavaScript
      language: javascript
      ---
       # Call Convenience methods for Stitch and JavaScript
      Some content here
    HEREDOC
  end
end
