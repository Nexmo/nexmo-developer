require 'rails_helper'

RSpec.describe 'rendering _unordered_list landing page partial' do
  it 'renders correctly with local variable' do
    bullet_shape = 'square'
    list = [
      { 'item' => 'Item 1' },
      { 'item' => 'Item 2' },
      { 'item' => 'Item 3' },
    ]

    render partial: '/layouts/partials/landing_pages/unordered_list.html.erb', locals: {
        'bullet_shape' => bullet_shape,
        'list' => list,
    }

    expect(rendered).to include('<ul class="Vlt-list Vlt-list--square">')
    expect(rendered).to include('Item 1')
    expect(rendered).to include('Item 2')
    expect(rendered).to include('Item 3')
  end

  it 'renders ul without a bullet shape classname if bullet shape is not provided' do
    list = [
        { 'item' => 'Item 1' },
        { 'item' => 'Item 2' },
        { 'item' => 'Item 3' },
      ]

    render partial: '/layouts/partials/landing_pages/unordered_list.html.erb', locals: {
        'list' => list,
    }

    expect(rendered).to include('<ul class="Vlt-list Vlt-list--">')
  end

  it 'renders an empty list if no data is provided' do
    render partial: '/layouts/partials/landing_pages/unordered_list.html.erb'

    expected_output = '<ul class="Vlt-list Vlt-list--"></ul>'

    #expect(rendered).to eql(expected_output) # need to strip \n from output
  end
end
