require 'rails_helper'

RSpec.describe MarkdownPipeline do
  context 'inline code examples' do
    it 'highlights PHP examples that begin with <?php' do
      input = <<~HEREDOC
        ```php
        <?php

        echo '<p>Hello World</p>';
        ```
      HEREDOC

      output = MarkdownPipeline.new.call(input)

      expect(output).to include('<pre class="highlight php"><code><span class="o">&lt;?</span>')
    end

    it 'highlights PHP examples that do not begin with <?php' do
      input = <<~HEREDOC
        ```php
        echo '<p>Hello World</p>';
        ```
      HEREDOC

      output = MarkdownPipeline.new.call(input)

      expect(output).to include('<pre class="highlight php"><code><span class="k">')
    end
  end

  context 'injected code examples' do
    before(:each) do
      allow(Rails.configuration).to receive(:docs_base_path).and_return('.')
    end

    it 'highlights PHP examples that begin with <?php' do
      input = <<~HEREDOC
        ```tabbed_examples
        source: 'spec/fixtures/filters/tabbed_examples_php_tagged'
        ```
      HEREDOC

      output = MarkdownPipeline.new.call(input)
      expect(output).to include('<span class="nv">')
    end

    it 'highlights PHP examples that do not begin with <?php' do
      input = <<~HEREDOC
        ```tabbed_examples
        source: 'spec/fixtures/filters/tabbed_examples_php_untagged'
        ```
      HEREDOC

      output = MarkdownPipeline.new.call(input)
      expect(output).to include('<span class="nv">')
    end
  end
end
