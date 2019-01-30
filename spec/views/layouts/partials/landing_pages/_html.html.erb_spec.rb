require 'rails_helper'

RSpec.describe 'rendering _html landing page partial' do
  it 'renders correctly with local variable' do
    content = '<a href="#a-tag">A link</a>'

    render partial: '/layouts/partials/landing_pages/html.html.erb', locals: { 'content' => content }

    expect(rendered).to include('<a href="#a-tag">A link</a>')
  end

  it 'renders nothing when input is not provided' do
    render partial: '/layouts/partials/landing_pages/html.html.erb'

    expect(rendered).to eql('')
  end
end
