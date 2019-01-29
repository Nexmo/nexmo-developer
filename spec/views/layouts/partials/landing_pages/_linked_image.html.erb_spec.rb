require 'rails_helper'

RSpec.describe 'rendering _linked_image landing page partial' do
  it 'renders correctly with local variables' do
    url = '#link-me'
    image = '/path/to/image'

    render partial: '/layouts/partials/landing_pages/linked_image.html.erb', locals: { 'url' => url, 'image' => image }

    expect(rendered).to include('<a href="#link-me">')
    expect(rendered).to include('<img src="/path/to/image" />')
  end
end
