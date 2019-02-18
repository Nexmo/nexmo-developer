require 'rails_helper'

RSpec.describe 'static/default_landing' do
  it 'renders all partials' do
    @landing_config = {
    'page' => [
      {
        'row' => [
          {
                'column' => [
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
              'column' => [
                {
                    'type' => 'contact_support',
                  },
                {
                  'type' => 'text',
                  'text' => {
                    'content' => 'Sample Text Block',
                  },
                },
              ],
          },
          {
                'width' => 2,
                'column' => [
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
        'row' => [
          {
                'column' => [
                  {
                        'type' => 'line_divider',
                    },
                ],
            },
          {
              'column' => [
                {
                      'type' => 'call_to_action',
                      'call_to_action' => {
                          'icon' => { 'name' => 'cta-icon-here', 'color' => 'orange' },
                          'title' => 'Call to Action Title',
                          'subtitle' => 'Call to Action Subtitle',
                          'url' => '/path/to/call/to/action/link',
                      },
                  },
              ],
          },
        ],
      },
      {
        'row' => [
          {
                'width' => 2,
                'column' => [
                  {
                        'type' => 'section_header',
                        'section_header' => {
                            'title' => 'Sample Title',
                            'icon' => { 'name' => 'test-icon', 'color' => 'blue' },
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
        'row' => [
          {
                'column' => [
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
                  {
                      'type' => 'github_repo',
                      'github_repo' => {
                          'repo_url' => 'https://www.github.com/Nexmo/repo',
                          'github_repo_title' => 'Repo Title',
                          'language' => 'Ruby',
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
    expect(actual).to include("<div class='Vlt-center'>")
    expect(actual).to include('Do you have a question?')
    expect(actual).to include('Sample Title')
    expect(actual).to include('Sample Text Block')
    expect(actual).to include('Ruby')
    expect(actual).to include('<a class="Vlt-card Nxd-github-card Vlt-left" href="https://www.github.com/Nexmo/repo" data-github="Nexmo/repo">')
    expect(actual).to include('p-large')
    expect(actual).to include('Second Sample Content')
    expect(actual).to include('Vlt-list--square')
    expect(actual).to include('Item 1')
    expect(actual).to include('Item 2')
    expect(actual).to include('Call to Action Subtitle')
    expect(actual).to include('Call to Action Title')
    expect(actual).to include('<use xlink:href="/symbol/volta-icons.svg#Vlt-cta-icon-here">')
  end
end
