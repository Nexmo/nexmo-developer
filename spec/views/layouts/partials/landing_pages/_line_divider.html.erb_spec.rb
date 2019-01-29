require 'rails_helper'

RSpec.describe 'rendering _line_divider landing page partial' do
  it 'renders correctly' do
    render partial: '/layouts/partials/landing_pages/line_divider.html.erb'

    expect(rendered).to include('<hr class="hr--tall" />')
  end
end
