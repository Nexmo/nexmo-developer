require 'rails_helper'

RSpec.describe 'rendering _call_to_action landing page partial' do
  it 'renders correctly with local variables' do
    icon_color = 'orange'
    icon = 'icon-here'
    title = 'A title here'
    subtitle = 'A subtitle here'

    render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
        'subtitle' => subtitle,
    }

    expect(rendered).to include('<svg class="Vlt-icon Vlt-icon--large Vlt-orange">')
    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-icon-here">')
    expect(rendered).to include('A title here')
    expect(rendered).to include('A subtitle here')
  end

  it 'raises an error when an icon color is not provided' do
    icon = 'icon-here'
    title = 'A title here'
    subtitle = 'A subtitle here'

    expect do
      render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon' => icon,
        'title' => title,
        'subtitle' => subtitle,
    }
    end .to raise_error("Missing 'icon_color' key in call_to_action landing page block")
  end

  it 'raises an error when an icon is not provided' do
    icon_color = 'orange'
    title = 'A title here'
    subtitle = 'A subtitle here'

    expect do
      render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon_color' => icon_color,
        'title' => title,
        'subtitle' => subtitle,
    }
    end .to raise_error("Missing 'icon' key in call_to_action landing page block")
  end

  it 'raises an error when a title is not provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    subtitle = 'A subtitle here'

    expect do
      render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'subtitle' => subtitle,
    }
    end .to raise_error("Missing 'title' key in call_to_action landing page block")
  end

  it 'renders without a subtitle when no subtitle is provided' do
    icon_color = 'orange'
    icon = 'icon-here'
    title = 'A title here'

    render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon_color' => icon_color,
        'icon' => icon,
        'title' => title,
    }

    expect(rendered).to_not include('A subtitle here')
  end
end
