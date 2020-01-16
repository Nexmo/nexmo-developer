require 'rails_helper'

RSpec.feature 'Team' do
  before do
    expect(Greenhouse).to receive(:devrel_careers).and_return(
      [
        Career.new(
          title: 'Developer Advocate',
          location: { name: 'Remote' },
          content: 'This is some example content',
          absolute_url: 'https://boards.greenhouse.io/vonage/jobs/123'
        ),
      ]
    )
  end

  scenario 'visiting the team page' do
    visit '/team'

    within('.Nxd-landing-main') do
      expect(page).to have_css('h1', text: 'Nexmo Developer Relations Team')
      expect(page).to have_link('the developer relations team', href: '#join')
      expect(page).to have_link('other teams at Nexmo', href: '/careers')
      expect(page).to have_css('.Nxd-profile').at_least(1).times
      expect(page).to have_css('h2', text: 'Contributors')
      expect(page).to have_link('Contributors', href: 'https://github.com/Nexmo/nexmo-developer/graphs/contributors')
      expect(page).to have_css('h2', text: 'Join the team')
    end
  end
end
