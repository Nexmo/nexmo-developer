require 'rails_helper'

RSpec.describe 'rendering _contact_community landing page partial' do
  it 'renders correctly' do
    render partial: '/static/default_landing/partials/contact_community.html.erb'

    expect(rendered).to include("<div class='Vlt-center'>")
    expect(rendered).to include('<h2>Get in touch</h2>')
    # remove all new line breaks and whitespace from following test:
    expect(rendered.tr("\n", ' ').gsub(/\s+/, '')).to include('<p class="p-large">Do you have a question'.tr("\n", ' ').gsub(/\s+/, ''))
  end
end
