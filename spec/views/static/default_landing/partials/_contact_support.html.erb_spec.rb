require 'rails_helper'

RSpec.describe 'rendering _contact_support landing page partial' do
  it 'renders correctly with local variable' do
    render partial: '/static/default_landing/partials/contact_support.html.erb', locals: {
        'align' => 'center',
        'header' => 'My header',
        'text' => [
          { 'type' => 'small', 'content' => 'Things here' },
          { 'type' => 'large', 'content' => 'Large things here' },
        ],
    }

    expect(rendered).to include("<div class='Vlt-center'>")
    expect(rendered).to include('My header')
    # remove all new line breaks and whitespace from following test:
    expect(rendered.tr("\n", ' ').gsub(/\s+/, '')).to include('<p class="p-large">Large things here'.tr("\n", ' ').gsub(/\s+/, ''))
    expect(rendered).to include('Things here')
  end

  it 'raises an error if a header is not provided' do
    expect do
      render partial: '/static/default_landing/partials/contact_support.html.erb', locals: {
        'align' => 'center',
        'text' => [
          { 'type' => 'small', 'content' => 'Things here' },
          { 'type' => 'large', 'content' => 'Large things here' },
        ],
    }
    end .to raise_error("Missing 'header' key in contact_support landing page block")
  end

  it 'raises an error if text is not provided' do
    expect do
      render partial: '/static/default_landing/partials/contact_support.html.erb', locals: {
        'align' => 'center',
        'header' => 'My header',
    }
    end .to raise_error("Missing 'text' key in contact_support landing page block")
  end

  it 'does not center content if the align key is not set to center' do
    render partial: '/static/default_landing/partials/contact_support.html.erb', locals: {
        'header' => 'My header',
        'text' => [
          { 'type' => 'small', 'content' => 'Things here' },
          { 'type' => 'large', 'content' => 'Large things here' },
        ],
    }

    expect(rendered).to_not include("<div class='Vlt-center'>")
  end
end
