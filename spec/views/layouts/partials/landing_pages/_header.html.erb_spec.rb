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

  it 'raises an error when an icon color is not provided' do
    icon = 'icon-here'
    title = 'A title here'
    subtitle = 'A subtitle here'

    expect do
      render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon' => icon,
        'title' => title,
        'subtitle' => subtitle,
    }
    end .to raise_error('Could not find header content')
  end

  it 'raises an error when an icon is not provided' do
    icon_color = 'orange'
    title = 'A title here'
    subtitle = 'A subtitle here'

    expect do
      render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon_color' => icon_color,
        'title' => title,
        'subtitle' => subtitle,
    }
    end .to raise_error('Could not find header content')
  end

  it 'raises an error when a title is not provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    subtitle = 'A subtitle here'

    expect do
      render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'subtitle' => subtitle,
    }
    end .to raise_error('Could not find header content')
  end

  it 'renders without a subtitle when no subtitle is provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    title = 'A title here'

    render partial: '/layouts/partials/landing_pages/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
    }

    expect(rendered).to_not include('A subtitle here')
  end
end
