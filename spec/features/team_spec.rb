require 'spec_helper'

RSpec.feature 'Team', type: :feature do
  background do
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

    within('.Nxd-landing-page') do
      # TODO: fix this, it should be an h1
      expect(page).to have_css('h2', text: 'Vonage API Developer Relations Team')
      expect(page).to have_link('the developer relations team', href: '#join')
      expect(page).to have_link('other teams at Nexmo', href: '/careers')
      expect(page).to have_css('.Nxd-profile').at_least(1).times
      expect(page).to have_css('h2', text: 'Contributors')
      expect(page).to have_link('Contributors', href: 'https://github.com/Nexmo/nexmo-developer/graphs/contributors')
      expect(page).to have_css('h2', text: 'Join the Team')
    end
  end
end
