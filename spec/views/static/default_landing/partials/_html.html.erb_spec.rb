require 'rails_helper'

RSpec.describe 'rendering _html landing page partial' do
  it 'renders correctly with local variable' do
    content = '<a href="#a-tag">A link</a>'

    render partial: '/static/default_landing/partials/html.html.erb', locals: { 'content' => content }

    expect(rendered).to include('<a href="#a-tag">A link</a>')
  end

  it 'raises error if there is no content' do
    expect { render partial: '/static/default_landing/partials/html.html.erb' }.to raise_error('Could not find HTML content')
  end
end
