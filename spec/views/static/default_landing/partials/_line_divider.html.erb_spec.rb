require 'rails_helper'

RSpec.describe 'rendering _line_divider landing page partial' do
  it 'renders correctly' do
    render partial: '/static/default_landing/partials/line_divider.html.erb'

    expect(rendered).to include('<hr class="hr--tall" />')
  end

 it 'renders correctly' do
    render partial: '/static/default_landing/partials/line_divider.html.erb', locals {
      'style' => 'hr--small'
    }

    expect(rendered).to include('<hr class="hr--small" />')
  end
end
