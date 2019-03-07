require 'rails_helper'

RSpec.describe 'rendering _featured_session landing page partial' do
  it 'renders correctly' do
    render partial: '/static/default_landing/partials/featured_session.html.erb'

    expect(rendered).to include('<iframe src=')
  end
end
