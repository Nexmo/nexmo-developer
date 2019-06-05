require 'rails_helper'

RSpec.describe 'rendering _events landing page partial' do
  it 'renders correctly' do
    render partial: '/static/default_landing/partials/events.html.erb'

    expect(rendered).to include('<div id="community-events" class="Vlt-grid">')
  end
end
