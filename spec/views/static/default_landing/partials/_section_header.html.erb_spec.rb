require 'rails_helper'

RSpec.describe 'rendering _section_header landing page partial' do
  it 'renders correctly with local variable' do
    icon_color = 'blue'
    icon = 'an-icon'
    title = 'Here is a title'

    render partial: '/static/default_landing/partials/section_header.html.erb', locals: {
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

    render partial: '/static/default_landing/partials/section_header.html.erb', locals: {
        'icon' => icon,
        'title' => title,
    }

    expect(rendered).to include('<svg class="Vlt-">')
    expect(rendered).to_not include('<svg class=Vlt-blue">')
  end

  it 'renders without an icon if no icon provided' do
    icon_color = 'blue'
    title = 'Here is a title'

    render partial: '/static/default_landing/partials/section_header.html.erb', locals: {
        'icon_color' => icon_color,
        'title' => title,
    }

    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-">')
    expect(rendered).to_not include('<use xlink:href="/symbol/volta-icons.svg#Vlt-an-icon">')
  end

  it 'raises an error if a title is not provided' do
    icon_color = 'blue'
    icon = 'an-icon'

    expect do
      render partial: '/static/default_landing/partials/section_header.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
    }
    end .to raise_error('Could not find Section Header title')
  end
end
