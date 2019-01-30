require 'rails_helper'

RSpec.describe 'rendering _header landing page partial' do
  it 'renders correctly with local variables' do
    icon_color = 'orange'
    icon = 'icon-here'
    title = 'A title here'
    subtitle = 'A subtitle here'

    render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
        'subtitle' => subtitle,
    }

    expect(rendered).to include('<svg class="Vlt-orange">')
    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-icon-here">')
    expect(rendered).to include('A title here')
    expect(rendered).to include('A subtitle here')
  end

  it 'renders without icon color when no color is provided' do
    icon = 'icon-here'
    title = 'A title here'
    subtitle = 'A subtitle here'

    render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon' => icon,
        'title' => title,
        'subtitle' => subtitle,
    }

    expect(rendered).to include('<svg class="Vlt-">')
  end

  it 'renders without an icon when no icon is provided' do
    icon_color = 'orange'
    title = 'A title here'
    subtitle = 'A subtitle here'

    render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon_color' => icon_color,
        'title' => title,
        'subtitle' => subtitle,
    }

    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-">')
  end

  it 'renders without a title when no title is provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    subtitle = 'A subtitle here'

    render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'subtitle' => subtitle,
    }

    expect(rendered).to_not include('A title here')
  end

  it 'renders without a subtitle when no subtitle is provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    title = 'A title here'
    subtitle = 'A subtitle here'

    render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
    }

    expect(rendered).to_not include('A subtitle here')
  end
end
