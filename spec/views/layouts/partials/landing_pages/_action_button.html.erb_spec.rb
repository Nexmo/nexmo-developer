require 'rails_helper'

RSpec.describe 'rendering _action_button landing page partial' do
  it 'renders correctly with local variables' do
    url_input = '#a-sample-url'
    text_input = 'Click here!'

    render partial: '/layouts/partials/landing_pages/action_button.html.erb', locals: { 'url' => url_input, 'text' => text_input }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="#a-sample-url">')
    expect(rendered).to include('Click here!')
  end

  it 'renders only the local variable provided to the partial' do
    url_input = '#a-sample-url'

    render partial: '/layouts/partials/landing_pages/action_button.html.erb', locals: { 'url' => url_input }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="#a-sample-url">')
    expect(rendered).not_to include('Click here!')
  end

  it 'renders default partial layout if no local variables are provided' do
    render partial: '/layouts/partials/landing_pages/action_button.html.erb'

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="">')
  end

  it 'ignores local variables provided to it in the rendering if not used' do
    url_input = '#a-sample-url'
    text_input = 'Click here!'
    another_variable = 'Ignore me'

    render partial: '/layouts/partials/landing_pages/action_button.html.erb', locals: { 'url' => url_input, 'text' => text_input }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="#a-sample-url">')
    expect(rendered).to include('Click here!')
    expect(rendered).to_not include('Ignore me')
  end
end
