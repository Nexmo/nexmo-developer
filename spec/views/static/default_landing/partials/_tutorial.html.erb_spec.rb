require 'rails_helper'

RSpec.describe 'rendering _tutorial landing page partial' do
  it 'renders correctly with valid data and an external_link defined' do
    tutorial = <<~HEREDOC
      ---
      title: This is a sample title
      external_link: https://sample.url/path/to/link/
      image_url: https://sample.url/path/to/image
      description: This is a sample description
      products: sms/messaging
      languages:
      - ruby
      ---
    HEREDOC
    allow(File).to receive(:read).and_return(tutorial)

    render partial: '/static/default_landing/partials/tutorial.html.erb', locals: { 'name' => 'this-is-a-sample' }

    expect(rendered).to include('<a class="Vlt-card" href="https://sample.url/path/to/link/">')
    expect(rendered).to include('src="https://sample.url/path/to/image"')
    expect(rendered).to include('<h4 class="Vlt-margin--top2">This is a sample title</h4>')
    expect(rendered).to include('<p>This is a sample description</p>')
  end

  it 'renders correctly with valid data and no external_link defined' do
    tutorial = <<~HEREDOC
      ---
      title: This is a sample title
      image_url: https://sample.url/path/to/image
      description: This is a sample description
      products: sms/messaging
      languages:
      - ruby
      ---
    HEREDOC
    allow(File).to receive(:read).and_return(tutorial)

    render partial: '/static/default_landing/partials/tutorial.html.erb', locals: { 'name' => 'this-is-a-sample' }

    expect(rendered).to include('<a class="Vlt-card" href="/use-cases/this-is-a-sample">')
    expect(rendered).to include('src="https://sample.url/path/to/image"')
    expect(rendered).to include('<h4 class="Vlt-margin--top2">This is a sample title</h4>')
    expect(rendered).to include('<p>This is a sample description</p>')
  end

  it 'raises an error if name key is not provided' do
    tutorial = <<~HEREDOC
      ---
      title: This is a sample title
      image_url: https://sample.url/path/to/image
      description: This is a sample description
      products: sms/messaging
      languages:
      - ruby
      ---
    HEREDOC
    allow(File).to receive(:read).and_return(tutorial)

    expect { render partial: '/static/default_landing/partials/tutorial.html.erb' }.to raise_error("Missing 'name' key in tutorial landing page block")
  end
end
