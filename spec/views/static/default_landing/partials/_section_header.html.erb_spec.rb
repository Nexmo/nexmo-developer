require 'rails_helper'

RSpec.describe 'rendering _section_header landing page partial' do
  it 'renders correctly with local variable' do
    render partial: '/static/default_landing/partials/section_header.html.erb', locals: {
        'icon' => { 'color' => 'blue', 'name' => 'an-icon' },
        'title' => 'Here is a title',
    }

    expect(rendered).to include('<svg class="Vlt-blue">')
    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-an-icon">')
    expect(rendered).to include('Here is a title')
  end

  it 'raises an error if icon color is not provided' do
    expect do
      render partial: '/static/default_landing/partials/section_header.html.erb', locals: {
        'icon' => { 'name' => 'an-icon' },
        'title' => 'Here is a title',
    }
    end .to raise_error("Missing icon 'color' key in section_header landing page block")
  end

  it 'raises an error if icon is not provided' do
    expect do
      render partial: '/static/default_landing/partials/section_header.html.erb', locals: {
        'icon' => { 'color' => 'blue' },
        'title' => 'Here is a title',
    }
    end .to raise_error("Missing icon 'name' key in section_header landing page block")
  end

  it 'raises an error if a title is not provided' do
    expect do
      render partial: '/static/default_landing/partials/section_header.html.erb', locals: {
        'icon_' => { 'name' => 'an-icon', 'color' => 'blue' },
        'icon' => 'an-icon',
    }
    end .to raise_error("Missing 'title' key in section_header landing page block")
  end
end
