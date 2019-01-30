require 'rails_helper'

RSpec.describe 'rendering _linked_image landing page partial' do
  it 'renders correctly with local variables' do
    url = '#link-me'
    image = '/path/to/image'

    render partial: '/layouts/partials/landing_pages/linked_image.html.erb', locals: { 'url' => url, 'image' => image }

    expect(rendered).to include('<a href="#link-me">')
    expect(rendered).to include('<img src="/path/to/image" />')
  end

  it 'does not render href or img tag content when url is not provided' do
    image = '/path/to/image'

    render partial: '/layouts/partials/landing_pages/linked_image.html.erb', locals: { 'image' => image }

    expect(rendered).to_not include('<a href=')
    expect(rendered).to_not include('<img src=')
  end

  it 'does not render an img tag when image is not provided' do
    url = '#link-me'

    render partial: '/layouts/partials/landing_pages/linked_image.html.erb', locals: { 'url' => url }

    expect(rendered).to include('<a href="#link-me">')
    expect(rendered).to_not include('<img src=')
  end
end
