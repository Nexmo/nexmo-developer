require 'rails_helper'

RSpec.describe CollapsibleFilter do
  it 'returns input unaltered if it does not match filter' do
    input = 'hello'

    expect(described_class.call(input)).to eq('hello')
  end

  it 'renders a collapsible HTML template with content from matching input' do
    input = "| ## Heading\n|\nContent\n\n"

    expected_output = <<~HEREDOC
      <div class="Vlt-accordion Vlt-box Vlt-box--lesspadding Nxd-accordion-emphasis">
        <h5 class="Vlt-accordion__trigger"  tabindex="0">Heading</h5>
        <div class="Vlt-accordion__content Vlt-accordion__content--noborder">
          <p>Content</p>
        </div>
      </div>
    HEREDOC

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'accepts up to six # characters as acceptable input to cause input alteration' do
    input = "| ###### Heading\n|\nContent\n\n"

    expected_output = <<~HEREDOC
      <div class="Vlt-accordion Vlt-box Vlt-box--lesspadding Nxd-accordion-emphasis">
        <h5 class="Vlt-accordion__trigger"  tabindex="0">Heading</h5>
        <div class="Vlt-accordion__content Vlt-accordion__content--noborder">
          <p>Content</p>
        </div>
      </div>
    HEREDOC

    expect(described_class.call(input)).to eq(expected_output)
  end

  it 'renders any # characters after the initial 6 as part of the output text' do
    input = "| ####### Heading\n|\nContent\n\n"

    expected_output = <<~HEREDOC
      <div class="Vlt-accordion Vlt-box Vlt-box--lesspadding Nxd-accordion-emphasis">
        <h5 class="Vlt-accordion__trigger"  tabindex="0"># Heading</h5>
        <div class="Vlt-accordion__content Vlt-accordion__content--noborder">
          <p>Content</p>
        </div>
      </div>
    HEREDOC

    expect(described_class.call(input)).to eq(expected_output)
  end
end
