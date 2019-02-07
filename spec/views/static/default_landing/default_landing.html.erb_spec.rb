require 'rails_helper'

RSpec.describe 'static/default_landing' do
  it 'renders all partials' do
    @landing_config = {
    'rows' => [
      {
        'columns' => [
          {
                'entries' => [
                  {
                        'type' => 'header',
                        'header' => {
                            'title' => { 'text' => 'Test Title', 'align' => 'center' },
                            'subtitle' => {
                              'text' => 'Test Subtitle',
                              'align' => 'center',
                              'type' => 'large',
                            },
                            'icon' => { 'name' => 'test-icon', 'color' => 'blue' },
                        },
                    },
                  {
                        'type' => 'action_button',
                        'action_button' => {
                            'text' => 'Test Action Button',
                            'url' => '#test-url',
                        },
                    },
                ],
            },
          {
                'width' => 2,
                'entries' => [
                  {
                        'type' => 'html',
                        'html' => {
                            'content' => '<a href="/path/to/link">Test HTML</a>',
                        },
                    },
                ],
            },
        ],
      },
      {
        'columns' => [
          {
                'entries' => [
                  {
                        'type' => 'line_divider',
                    },
                ],
            },
        ],
      },
      {
        'columns' => [
          {
                'width' => 2,
                'entries' => [
                  {
                        'type' => 'section_header',
                        'section_header' => {
                            'title' => 'Sample Title',
                            'icon' => [
                              { 'name' => 'test-icon', 'color' => 'blue' },
                            ],
                        },
                    },
                  {
                        'type' => 'linked_image',
                        'linked_image' => {
                            'image' => '/path/to/image',
                            'url' => '/path/to/url',
                            'alt_text' => 'Test Alt Text',
                        },
                    },
                  {
                        'type' => 'structured_text',
                        'structured_text' => {
                            'header' => 'Sample Header',
                            'icon' => { 'name' => 'test-icon', 'color' => 'blue' },
                            'text' => [
                              { 'content' => 'Sample Content', 'type' => 'large' },
                              { 'content' => 'Second Sample Content', 'type' => 'small' },
                            ],
                        },
                    },
                ],
            },
        ],
      },
      {
        'columns' => [
          {
                'entries' => [
                  {
                        'type' => 'unordered_list',
                        'unordered_list' => {
                            'bullet_shape' => 'square',
                            'list' => [
                              { 'item' => 'Item 1' },
                              { 'item' => 'Item 2' },
                            ],
                        },
                    },
                ],
            },
        ],
        },
    ],
}
    erb = File.read("#{Rails.root}/app/views/static/default_landing.html.erb")
    actual = ERB.new(erb).result(binding)

    expect(actual).to include('Vlt-title--icon')
    expect(actual).to include('Vlt-blue')
    expect(actual).to include('Test Title')
    expect(actual).to include('Test Action Button')
    expect(actual).to include('Test HTML')
    expect(actual).to include('hr--tall')
    expect(actual).to include('Sample Title')
    expect(actual).to include('p-large')
    expect(actual).to include('Second Sample Content')
    expect(actual).to include('Vlt-list--square')
    expect(actual).to include('Item 1')
    expect(actual).to include('Item 2')
  end
end
