require "rails_helper"

RSpec.describe "rendering _action_button landing page partial" do
  it "renders correctly with local variables" do
    url_input = '#a-sample-url'
    text_input = 'Click here!'

    render :partial => "/layouts/partials/landing_pages/action_button.html.erb", :locals => {'url' => url_input, 'text' => text_input}

    expect(rendered).to include('<a class="Vlt-btn Vlt-btn--primary" href="#a-sample-url">')
    expect(rendered).to include('Click here!')
  end
end