require 'rails_helper'

RSpec.describe 'rendering _tutorial landing page partial' do
  before do
    assign(:language, I18n.default_locale)
  end

  context 'with a valid file' do
    before do
      expect(DocFinder).to receive(:find).with(
        root: 'config/tutorials',
        document: 'this-is-a-sample.yml',
        language: I18n.default_locale
      ).and_return('config/tutorials/en/this-is-a-sample.yml')
      expect(File).to receive(:exist?).with('config/tutorials/en/this-is-a-sample.yml').and_return(true)
    end

    it 'renders correctly with valid data and an external_link defined' do
      tutorial = <<~HEREDOC
        ---
        title: This is a sample title
        external_link: https://sample.url/path/to/link/
        image_url: https://sample.url/path/to/image
        description: This is a sample description
        products:
          - sms/messaging
        languages:
        - ruby
        ---
      HEREDOC
      expect(File).to receive(:read).and_return(tutorial)

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
        products:
          - sms/messaging
        languages:
        - ruby
        ---
      HEREDOC
      expect(File).to receive(:read).and_return(tutorial)

      render partial: '/static/default_landing/partials/tutorial.html.erb', locals: { 'name' => 'this-is-a-sample' }

      expect(rendered).to include('<a class="Vlt-card" href="/use-cases/this-is-a-sample">')
      expect(rendered).to include('src="https://sample.url/path/to/image"')
      expect(rendered).to include('<h4 class="Vlt-margin--top2">This is a sample title</h4>')
      expect(rendered).to include('<p>This is a sample description</p>')
    end
  end

  it 'raises an error if name key is not provided' do
    expect { render partial: '/static/default_landing/partials/tutorial.html.erb' }.to raise_error("Missing 'name' key in tutorial landing page block")
  end
end
