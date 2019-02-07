require 'rails_helper'

RSpec.describe 'rendering _header landing page partial' do
  it 'renders correctly with local variables' do
    render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon' => { 'name' => 'icon-here', 'color' => 'orange' },
        'title' => { 'text' => 'A title here', 'align' => 'center' },
        'subtitle' => [
          { 'text' => 'A subtitle here', 'align' => 'center', 'type' => 'small' },
        ],
    }

    expect(rendered).to include('<svg class="Vlt-orange">')
    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-icon-here">')
    expect(rendered).to include('A title here')
    expect(rendered).to include('A subtitle here')
  end

  it 'raises an error when an icon color is not provided' do
    expect do
      render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon' => { 'name' => 'icon-here' },
        'title' => { 'text' => 'A title here', 'align' => 'center' },
        'subtitle' => [
          { 'text' => 'A subtitle here', 'align' => 'center', 'type' => 'small' },
        ],
    }
    end .to raise_error("Missing icon 'color' key in header landing page block")
  end

  it 'raises an error when an icon name is not provided' do
    expect do
      render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon' => { 'color' => 'orange' },
        'title' => { 'text' => 'A title here', 'align' => 'center' },
        'subtitle' => [
          { 'text' => 'A subtitle here', 'align' => 'center', 'type' => 'small' },
        ],
    }
    end .to raise_error("Missing icon 'name' key in header landing page block")
  end

  it 'raises an error when a title is not provided' do
    expect do
      render partial: '/static/default_landing/partials/header.html.erb', locals: {
        'icon' => { 'name' => 'icon-here', 'color' => 'orange' },
        'subtitle' => [
          { 'text' => 'A subtitle here', 'align' => 'center', 'type' => 'small' },
        ],
    }
    end .to raise_error("Missing 'title' key in header landing page block")
  end

  it 'renders without a subtitle when no subtitle is provided' do
    render partial: '/static/default_landing/partials/header.html.erb', locals: {
      'icon' => { 'name' => 'icon-here', 'color' => 'orange' },
      'title' => { 'text' => 'A title here', 'align' => 'center' },
    }

    expect(rendered).to_not include('A subtitle here')
  end
end
