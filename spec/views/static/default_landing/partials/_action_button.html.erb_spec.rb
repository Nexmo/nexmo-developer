require 'rails_helper'

RSpec.describe 'rendering _action_button landing page partial' do
  it 'renders correctly with local variables' do
    render partial: '/static/default_landing/partials/action_button.html.erb', locals: {
      'url' => '#a-sample-url',
      'text' => 'Click here!',
    }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary " href="#a-sample-url">')
    expect(rendered).to include('Click here!')
  end

  it 'ignores local variables provided to it in the rendering if not used' do
    render partial: '/static/default_landing/partials/action_button.html.erb', locals: {
      'url' => '#a-sample-url',
      'text' => 'Click here!',
      'another_variable' => 'Ignore me',
    }

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary " href="#a-sample-url">')
    expect(rendered).to include('Click here!')
    expect(rendered).to_not include('Ignore me')
  end

  it 'raises an error if url is not provided' do
    expect do
      render partial: '/static/default_landing/partials/action_button.html.erb', locals: {
      'text' => 'Click here!',
      }
    end    .to raise_error("missing 'url' key in action_button landing page block")
  end

  it 'raises an error if text is not provided' do
    expect do
      render partial: '/static/default_landing/partials/action_button.html.erb', locals: {
      'url' => '#a-sample-url',
      }
    end    .to raise_error("missing 'text' key in action_button landing page block")
  end
end
