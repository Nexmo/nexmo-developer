require 'rails_helper'

RSpec.describe 'rendering _action_button landing page partial' do
  it 'renders correctly with local variables' do
    url_input = '#a-sample-url'
    text_input = 'Click here!',
    large = false
    type = 'primary'

    render partial: '/static/default_landing/partials/action_button.html.erb', locals: { 'url' => url_input, 'text' => text_input, 'large' => large, 'type' => type }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="#a-sample-url">')
    expect(rendered).to include('Click here!')
  end

  it 'ignores local variables provided to it in the rendering if not used' do
    url_input = '#a-sample-url'
    text_input = 'Click here!'
    large = false
    type = 'primary'
    another_variable = 'Ignore me'

    render partial: '/static/default_landing/partials/action_button.html.erb', locals: {
      'url' => url_input, 'text' => text_input, 'another_variable' => another_variable, 'large' => large, 'type' => type
    }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="#a-sample-url">')
    expect(rendered).to include('Click here!')
    expect(rendered).to_not include('Ignore me')
  end

  it 'raises an error if url is not provided' do
    text_input = 'Click here!'
    large = false
    type = 'primary'

    expect { render partial: '/static/default_landing/partials/action_button.html.erb', locals: { 'text_input' => text_input, 'large' => large, 'type' => type } }.to raise_error("missing 'url' key in action_button landing page block")
  end

  it 'raises an error if text_input is not provided' do
    url = '#a-sample-url'
    large = false
    type = 'primary'

    expect { render partial: '/static/default_landing/partials/action_button.html.erb', locals: { 'url' => url, 'large' => large, 'type' => type } }.to raise_error("missing 'text' key in action_button landing page block")
  end

  it 'raises an error if large key value is not true or false' do
    text_input = 'Click here!'
    url = '#a-sample-url'
    large = 'hello'
    type = 'primary'

    expect do
      render partial: '/static/default_landing/partials/action_button.html.erb', locals: {
        'url' => url,
        'text' => text_input,
        'large' => large,
        'type' => type,
      }
    end.to raise_error("Unknown value for 'large' key: #{large}")
  end
end
