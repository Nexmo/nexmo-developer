require 'rails_helper'

RSpec.describe 'rendering _action_button landing page partial' do
  it 'renders correctly with local variables' do
    url_input = '#a-sample-url'
    text_input = 'Click here!'

    render partial: '/layouts/partials/landing_pages/action_button.html.erb', locals: { 'url' => url_input, 'text' => text_input }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="#a-sample-url">')
    expect(rendered).to include('Click here!')
  end

  it 'ignores local variables provided to it in the rendering if not used' do
    url_input = '#a-sample-url'
    text_input = 'Click here!'
    another_variable = 'Ignore me'

    render partial: '/layouts/partials/landing_pages/action_button.html.erb', locals: {
      'url' => url_input, 'text' => text_input, 'another_variable' => another_variable
    }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="#a-sample-url">')
    expect(rendered).to include('Click here!')
    expect(rendered).to_not include('Ignore me')
  end

  it 'raises an error if all data is not provided' do
    expect { render partial: '/layouts/partials/landing_pages/action_button.html.erb' }.to raise_error('Could not find action button content')
  end

  it 'raises an error if url is not provided' do
    text_input = 'Click here!'

    expect { render partial: '/layouts/partials/landing_pages/action_button.html.erb', locals: { 'text_input' => text_input } }.to raise_error('Could not find action button content')
  end

  it 'raises an error if text_input is not provided' do
    url = '#a-sample-url'

    expect { render partial: '/layouts/partials/landing_pages/action_button.html.erb', locals: { 'url' => url } }.to raise_error('Could not find action button content')
  end
end
