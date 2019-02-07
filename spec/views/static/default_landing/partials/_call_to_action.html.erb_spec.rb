require 'rails_helper'

RSpec.describe 'rendering _call_to_action landing page partial' do
  it 'renders correctly with local variables' do
    render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon_color' => 'orange',
        'icon' => 'icon-here',
        'title' => 'A title here',
        'subtitle' => 'A subtitle here',
        'url' => '/path/to/link',
    }

    expect(rendered).to include('<svg class="Vlt-icon Vlt-icon--large Vlt-orange">')
    expect(rendered).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-icon-here">')
    expect(rendered).to include('A title here')
    expect(rendered).to include('A subtitle here')
  end

  it 'raises an error when an icon color is not provided' do
    expect do
      render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon' => 'icon-here',
        'title' => 'A title here',
        'subtitle' => 'A subtitle here',
        'url' => '/path/to/link',
    }
    end .to raise_error("Missing 'icon_color' key in call_to_action landing page block")
  end

  it 'raises an error when an icon is not provided' do
    expect do
      render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon_color' => 'orange',
        'title' => 'A title here',
        'subtitle' => 'A subtitle here',
        'url' => '/path/to/link',
    }
    end .to raise_error("Missing 'icon' key in call_to_action landing page block")
  end

  it 'raises an error when a title is not provided' do
    expect do
      render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon_color' => 'orange',
        'icon' => 'icon-here',
        'subtitle' => 'A subtitle here',
        'url' => '/path/to/link',
    }
    end .to raise_error("Missing 'title' key in call_to_action landing page block")
  end

  it 'raises an error when a url is not provided' do
    expect do
      render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
        'icon_color' => 'orange',
        'icon' => 'icon-here',
        'title' => 'A title here',
        'subtitle' => 'A subtitle here',
    }
    end .to raise_error("Missing 'url' key in call_to_action landing page block")
  end

  it 'renders without a subtitle when no subtitle is provided' do
    render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
      'icon_color' => 'orange',
      'icon' => 'icon-here',
      'title' => 'A title here',
      'url' => '/path/to/link',
    }
    expect(rendered).to_not include('A subtitle here')
  end

  it 'renders optional text values correctly' do
    render partial: '/static/default_landing/partials/call_to_action.html.erb', locals: {
      'icon_color' => 'orange',
      'icon' => 'icon-here',
      'title' => 'A title here',
      'url' => '/path/to/link',
      'text' => [
        { 'type' => 'small', 'content' => 'Things here' },
        { 'type' => 'large', 'content' => 'Large things here' },
      ],
    }
    expect(rendered.tr("\n", ' ').gsub(/\s+/, '')).to include('<p class="p-large">Large things here'.tr("\n", ' ').gsub(/\s+/, ''))
    expect(rendered).to include('Things here')
  end
end
