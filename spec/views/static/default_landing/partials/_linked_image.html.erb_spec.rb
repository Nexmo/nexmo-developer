require 'rails_helper'

RSpec.describe 'rendering _linked_image landing page partial' do
  it 'renders correctly with local variables' do
    render partial: '/static/default_landing/partials/linked_image.html.erb', locals: { 'url' => '#link-me', 'image' => '/path/to/image' }

    expect(rendered).to include('<a href="#link-me">')
    expect(rendered).to include('<img src="/path/to/image" />')
  end

  it 'raises an error if image path is not provided' do
    expect do
      render partial: '/static/default_landing/partials/linked_image.html.erb', locals: { 'url' => '#link-me' }
    end.to raise_error("Missing 'image' key in linked_image landing page block")
  end

  it 'raises an error if href link is not provided' do
    expect do
      render partial: '/static/default_landing/partials/linked_image.html.erb', locals: { 'image' => '/path/to/image' }
    end.to raise_error("Missing 'url' key in linked_image landing page block")
  end
end
