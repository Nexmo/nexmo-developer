require 'rails_helper'

RSpec.describe 'rendering _header landing page partial' do
  it 'renders correctly with local variables' do
    icon_color = 'orange'
    icon = 'icon-here'
    title = 'A title here'
    center_title = 'false'
    subtitle = 'A subtitle here'
    center_subtitle = 'false'

    render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
        'center_title' => center_title,
        'subtitle' => subtitle,
        'center_subtitle' => center_subtitle,
    }

    expect(rendered).to include('<svg class="Vlt-orange">')
    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-icon-here">')
    expect(rendered).to include('A title here')
    expect(rendered).to include('A subtitle here')
  end

  it 'raises an error when an icon color is not provided' do
    icon = 'icon-here'
    title = 'A title here'
    center_title = 'false'
    subtitle = 'A subtitle here'
    center_subtitle = 'false'

    expect do
      render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon' => icon,
        'title' => title,
        'center_title' => center_title,
        'subtitle' => subtitle,
        'center_subtitle' => center_subtitle,
    }
    end .to raise_error("Missing 'icon_color' key in header landing page block")
  end

  it 'raises an error when an icon is not provided' do
    icon_color = 'orange'
    title = 'A title here'
    center_title = 'false'
    subtitle = 'A subtitle here'
    center_subtitle = 'false'

    expect do
      render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon_color' => icon_color,
        'title' => title,
        'center_title' => center_title,
        'subtitle' => subtitle,
        'center_subtitle' => center_subtitle,
    }
    end .to raise_error("Missing 'icon' key in header landing page block")
  end

  it 'raises an error when a title is not provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    center_title = 'false'
    subtitle = 'A subtitle here'
    center_subtitle = 'false'

    expect do
      render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'center_title' => center_title,
        'subtitle' => subtitle,
        'center_subtitle' => center_subtitle,
    }
    end .to raise_error("Missing 'title' key in header landing page block")
  end

  it 'raises an error when center_title key value is not provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    title = 'A title here'
    subtitle = 'A subtitle here'
    center_subtitle = 'false'

    expect do
      render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
        'subtitle' => subtitle,
        'center_subtitle' => center_subtitle,
    }
    end .to raise_error("Missing 'center_title' key in header landing page block")
  end

  it 'renders without a subtitle when no subtitle is provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    title = 'A title here'
    center_title = 'false'

    render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
        'center_title' => center_title,
    }

    expect(rendered).to_not include('A subtitle here')
  end
end
