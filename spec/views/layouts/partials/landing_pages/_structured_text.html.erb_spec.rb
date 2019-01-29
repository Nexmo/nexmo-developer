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
    expect(rendered).to include('<p class="p-large">')
    expect(rendered).to include('Things here')
  end
end
