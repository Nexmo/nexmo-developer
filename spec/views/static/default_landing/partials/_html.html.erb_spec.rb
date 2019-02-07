require 'rails_helper'

RSpec.describe 'rendering _html landing page partial' do
  it 'renders correctly with local variable' do
    render partial: '/static/default_landing/partials/html.html.erb', locals: { 'content' => '<a href="#a-tag">A link</a>' }

    expect(rendered).to include('<a href="#a-tag">A link</a>')
  end

  it 'raises error if there is no content' do
    expect { render partial: '/static/default_landing/partials/html.html.erb' }.to raise_error("Missing 'content' key in HTML landing page block")
  end
end
