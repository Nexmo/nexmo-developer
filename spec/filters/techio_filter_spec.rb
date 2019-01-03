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

    expected_output = <<~HEREDOC
      <div class="techio-container">
        <iframe width="100%" frameborder="0" scrolling="no" allowtransparency="true" style="visibility: hidden" src="https://tech.io/playground-widget/here/is/a/path/this is a title"></iframe>
        <script>if(typeof window.techioScriptInjected==="undefined"){window.techioScriptInjected=true;var d=document,s=d.createElement("script");s.src="https://files.codingame.com/codingame/iframe-v-1-4.js";(d.head||d.body).appendChild(s);}</script>
      </div>
    HEREDOC

    # .chop off trailing \n from input
    expect(described_class.call(input.chop)).to eql(expected_output)
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

    expected_output = <<~HEREDOC
      <div class="techio-container">
        <iframe width="100%" frameborder="0" scrolling="no" allowtransparency="true" style="visibility: hidden" src="https://tech.io/playground-widget/here/is/a/path/"></iframe>
        <script>if(typeof window.techioScriptInjected==="undefined"){window.techioScriptInjected=true;var d=document,s=d.createElement("script");s.src="https://files.codingame.com/codingame/iframe-v-1-4.js";(d.head||d.body).appendChild(s);}</script>
      </div>
    HEREDOC

    # .chop off trailing \n from input
    expect(described_class.call(input.chop)).to eql(expected_output)
  end

  it 'returns HTML and JS script tags with no path in the iframe src if path is missing' do
    input = <<~HEREDOC
      ```techio
      path:
      title: this is a title
      ```
    HEREDOC

    expected_output = <<~HEREDOC
      <div class="techio-container">
        <iframe width="100%" frameborder="0" scrolling="no" allowtransparency="true" style="visibility: hidden" src="https://tech.io/playground-widget/this is a title"></iframe>
        <script>if(typeof window.techioScriptInjected==="undefined"){window.techioScriptInjected=true;var d=document,s=d.createElement("script");s.src="https://files.codingame.com/codingame/iframe-v-1-4.js";(d.head||d.body).appendChild(s);}</script>
      </div>
    HEREDOC

    # .chop off trailing \n from input
    expect(described_class.call(input.chop)).to eql(expected_output)
  end

  it 'returns HTML and JS script tags with no title in the iframe src path if title is completely missing' do
    input = <<~HEREDOC
      ```techio
      path: /here/is/a/path
      ```
    HEREDOC

    expected_output = <<~HEREDOC
      <div class="techio-container">
        <iframe width="100%" frameborder="0" scrolling="no" allowtransparency="true" style="visibility: hidden" src="https://tech.io/playground-widget/here/is/a/path/"></iframe>
        <script>if(typeof window.techioScriptInjected==="undefined"){window.techioScriptInjected=true;var d=document,s=d.createElement("script");s.src="https://files.codingame.com/codingame/iframe-v-1-4.js";(d.head||d.body).appendChild(s);}</script>
      </div>
    HEREDOC

    # .chop off trailing \n from input
    expect(described_class.call(input.chop)).to eql(expected_output)
  end

  it 'returns HTML and JS script tags with no path in the iframe src if path is completely missing' do
    input = <<~HEREDOC
      ```techio
      title: this is a title
      ```
    HEREDOC

    expected_output = <<~HEREDOC
      <div class="techio-container">
        <iframe width="100%" frameborder="0" scrolling="no" allowtransparency="true" style="visibility: hidden" src="https://tech.io/playground-widget/this is a title"></iframe>
        <script>if(typeof window.techioScriptInjected==="undefined"){window.techioScriptInjected=true;var d=document,s=d.createElement("script");s.src="https://files.codingame.com/codingame/iframe-v-1-4.js";(d.head||d.body).appendChild(s);}</script>
      </div>
    HEREDOC

    # .chop off trailing \n from input
    expect(described_class.call(input.chop)).to eql(expected_output)
  end
end
