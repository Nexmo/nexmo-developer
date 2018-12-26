require 'rails_helper'

RSpec.describe PartialFilter do 
    it 'renders input as HTML with config["platform"] set to true' do 
        input = <<~HEREDOC
        ```partial
        source: _partials/stitch/guides/calling-users/javascript.md
        platform: true
        ```
        HEREDOC

        expected_output = <<~HEREDOC
        <div class="js-platform" data-platform="true" data-active="false">
        HEREDOC

        expect(described_class.call(input)).to include(expected_output)
    end

    it 'renders input as markdown with config["platform"] not included' do 
        input = <<~HEREDOC
        ```partial
        source: _partials/stitch/guides/calling-users/javascript.md
        ```
        HEREDOC

        expected_output = <<~HEREDOC
        ---
        title: JavaScript
        language: javascript
        ---
        HEREDOC

        expect(described_class.call(input)).to include(expected_output)
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
end