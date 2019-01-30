require 'rails_helper'

RSpec.describe 'rendering _section_header landing page partial' do
  it 'renders correctly with local variable' do
    icon_color = 'blue'
    icon = 'an-icon'
    title = 'Here is a title'

    render partial: '/layouts/partials/landing_pages/section_header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
    }

    expect(rendered).to include('<svg class="Vlt-blue">')
    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-an-icon">')
    expect(rendered).to include('Here is a title')
  end

  it 'renders an icon svg tag without a color if no icon color provided' do
    icon = 'an-icon'
    title = 'Here is a title'

    render partial: '/layouts/partials/landing_pages/section_header.html.erb', locals: {
        'icon' => icon,
        'title' => title,
    }

    expect(rendered).to include('<svg class="Vlt-">')
    expect(rendered).to_not include('<svg class=Vlt-blue">')
  end

  it 'renders without an icon if no icon provided' do
    icon_color = 'blue'
    title = 'Here is a title'

    render partial: '/layouts/partials/landing_pages/section_header.html.erb', locals: {
        'icon_color' => icon_color,
        'title' => title,
    }

    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-">')
    expect(rendered).to_not include('<use xlink:href="/symbol/volta-icons.svg#Vlt-an-icon">')
  end

  it 'does not render a title if no title provided' do
    icon_color = 'blue'
    icon = 'an-icon'

    render partial: '/layouts/partials/landing_pages/section_header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
    }

    expect(rendered).to_not include('Here is a title')
  end
end
