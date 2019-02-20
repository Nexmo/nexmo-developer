require 'rails_helper'

RSpec.describe 'rendering _join_slack landing page partial' do
  it 'renders correctly' do
    render partial: '/static/default_landing/partials/join_slack.html.erb'

    expect(rendered).to include('<a class="Vlt-text-btn" href="/community/slack">')
  end
end
