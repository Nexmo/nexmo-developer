require 'rails_helper'

RSpec.describe 'rendering _structured_text landing page partial' do
  it 'renders correctly with local variable' do
    icon_color = 'blue'
    icon = 'nexmo-circle'
    header = 'My header'
    text = [
      { 'type' => 'small', 'content' => 'Things here' },
      { 'type' => 'large', 'content' => 'Large things here' },
    ]

    render partial: '/layouts/partials/landing_pages/structured_text.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'header' => header,
        'text' => text,
    }

    expect(rendered).to include('<svg class="Vlt-blue">')
    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-nexmo-circle">')
    expect(rendered).to include('My header')
    # remove all new line breaks and whitespace from following test:
    expect(rendered.tr("\n", ' ').gsub(/\s+/, '')).to include('<p class="p-large">Large things here'.tr("\n", ' ').gsub(/\s+/, ''))
    expect(rendered).to include('Things here')
  end

  it 'does not render an svg tag with a color if no color is provided' do
    icon = 'nexmo-circle'
    header = 'My header'
    text = [
      { 'type' => 'small', 'content' => 'Things here' },
      { 'type' => 'large', 'content' => 'Large things here' },
    ]

    render partial: '/layouts/partials/landing_pages/structured_text.html.erb', locals: {
        'icon' => icon,
        'header' => header,
        'text' => text,
    }

    expect(rendered).to include('<svg class="Vlt-">')
    expect(rendered).to_not include('<svg class="Vlt-blue">')
  end

  it 'does not render an use tag with an icon if no icon is specified' do
    icon_color = 'blue'
    header = 'My header'
    text = [
      { 'type' => 'small', 'content' => 'Things here' },
      { 'type' => 'large', 'content' => 'Large things here' },
    ]

    render partial: '/layouts/partials/landing_pages/structured_text.html.erb', locals: {
        'icon_color' => icon_color,
        'header' => header,
        'text' => text,
    }

    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-">')
    expect(rendered).to_not include('<use xlink:href="/symbol/volta-icons.svg#Vlt-nexmo-circle">')
  end

  it 'does not render a header if no header is provided' do
    icon_color = 'blue'
    icon = 'nexmo-circle'
    text = [
      { 'type' => 'small', 'content' => 'Things here' },
      { 'type' => 'large', 'content' => 'Large things here' },
    ]

    render partial: '/layouts/partials/landing_pages/structured_text.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'text' => text,
    }

    expect(rendered).to_not include('My header')
  end

  it 'does not render text content type if no text is provided' do
    icon_color = 'blue'
    icon = 'nexmo-circle'
    header = 'My header'

    render partial: '/layouts/partials/landing_pages/structured_text.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'header' => header,
    }

    expect(rendered).to_not include('<p class="p-large">')
    expect(rendered).to_not include('<p>')
  end
end
