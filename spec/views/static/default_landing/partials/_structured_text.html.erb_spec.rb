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

    render partial: '/static/default_landing/partials/structured_text.html.erb', locals: {
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

  it 'raises an error if icon color is not provided' do
    icon = 'nexmo-circle'
    header = 'My header'
    text = [
      { 'type' => 'small', 'content' => 'Things here' },
      { 'type' => 'large', 'content' => 'Large things here' },
    ]

    expect do
      render partial: '/static/default_landing/partials/structured_text.html.erb', locals: {
        'icon' => icon,
        'header' => header,
        'text' => text,
    }
    end .to raise_error('Could not find structured text content')
  end

  it 'raises an error if an icon is not provided' do
    icon_color = 'blue'
    header = 'My header'
    text = [
      { 'type' => 'small', 'content' => 'Things here' },
      { 'type' => 'large', 'content' => 'Large things here' },
    ]

    expect do
      render partial: '/static/default_landing/partials/structured_text.html.erb', locals: {
        'icon_color' => icon_color,
        'header' => header,
        'text' => text,
    }
    end .to raise_error('Could not find structured text content')
  end

  it 'raises an error if a header is not provided' do
    icon_color = 'blue'
    icon = 'nexmo-circle'
    text = [
      { 'type' => 'small', 'content' => 'Things here' },
      { 'type' => 'large', 'content' => 'Large things here' },
    ]

    expect do
      render partial: '/static/default_landing/partials/structured_text.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'text' => text,
    }
    end .to raise_error('Could not find structured text content')
  end

  it 'raises an error if text is not provided' do
    icon_color = 'blue'
    icon = 'nexmo-circle'
    header = 'My header'

    expect do
      render partial: '/static/default_landing/partials/structured_text.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'header' => header,
    }
    end    .to raise_error('Could not find structured text content')
  end

  it 'raises an error if no data is provided' do
    expect { render partial: '/static/default_landing/partials/structured_text.html.erb' }.to raise_error('Could not find structured text content')
  end
end
