require 'rails_helper'

RSpec.describe 'rendering _text landing page partial' do
  it 'renders correctly with proper data' do
    render partial: '/static/default_landing/partials/text.html.erb', locals: { 'content' => 'Sample Text' }

    expect(rendered).to include('Sample Text')
  end

  it 'raises an error if content is not provided' do
    expect { render partial: '/static/default_landing/partials/text.html.erb' }.to raise_error("Missing 'content' key in text landing page block")
  end
end
