require 'rails_helper'

RSpec.feature 'Team' do
  before do
    expect(Greenhouse).to receive(:careers).and_return([
                                                         Career.new({
                                                           title: 'Developer Advocate',
                                                           location: { name: 'Remote' },
                                                           content: 'This is some example content',
                                                           absolute_url: 'https://boards.greenhouse.io/vonage/jobs/123',
                                                         }),
                                                       ])
  end

  scenario 'visiting the team page' do
    visit '/team'

    within('.Nxd-landing-main') do
      expect(page).to have_css('h1', text: 'Nexmo Developer Relations Team')
      expect(page).to have_css('p:nth-of-type(1)', text: 'Our mission is to build a world-class open source documentation platform to help developers build connected products.')

      within('p:nth-of-type(2)') do
        expect(page).to have_content('Here are some of the people behind Nexmo Developer. Oh, and we\'re hiring for')
        expect(page).to have_link('the developer relations team', href: '#join')
        expect(page).to have_content('and')
        expect(page).to have_link('other teams at Nexmo', href: 'https://www.vonage.com/corporate/careers/')
      end

      within('.Vlt-grid:nth-of-type(1)') do
        expect(page).to have_css('.Nxd-profile', count: 25)
      end

      expect(page).to have_css('h2', text: 'Alumni')

      within('.Vlt-grid:nth-of-type(2)') do
        expect(page).to have_css('.Nxd-profile', count: 6)
      end

      expect(page).to have_css('h2', text: 'Contributors')
      expect(page).to have_css('p', text: 'Many of the improvements made to Nexmo Developer have come from our wonderful community.')
      expect(page).to have_css('p', text: 'Check out our Contributors page on GitHub.')
      expect(page).to have_link('Contributors', href: 'https://github.com/Nexmo/nexmo-developer/graphs/contributors')

      within('.Vlt-grid:nth-of-type(3)') do
        within('.Vlt-col:nth-of-type(1)') do
          expect(page).to have_link(href: '/spotlight')
        end
        within('.Vlt-col--3of4') do
          expect(page).to have_css('h2', text: 'Write for Nexmo')
          expect(page).to have_content('You don\'t have to be part of the team to write for Nexmo.')
          expect(page).to have_link('Developer Spotlight', href: '/spotlight')
          expect(page).to have_content('Thanks to our Developer Spotlight program, you can get paid $400 to write for us.')
        end
      end

      expect(page).to have_css('h2', text: 'Join the team')
    end
  end
end
