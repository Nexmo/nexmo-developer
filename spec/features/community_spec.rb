require 'rails_helper'

RSpec.feature 'Community' do
  let!(:euruko)        { FactoryBot.create(:event) }
  let!(:video_session) { FactoryBot.create(:session) }

  let!(:date_range) do
    start_date = euruko.starts_at.strftime('%-d %B %Y')
    end_date = euruko.ends_at.strftime('%-d %B %Y')
    "#{start_date} - #{end_date}"
  end

  background do
    FactoryBot.create(:past_event)
    FactoryBot.create_list(:session, 3)
  end

  scenario 'visiting the community page' do
    visit '/community'

    within('.Nxd-landing-page') do
      expect(page).to have_css('h1#vonage-community', text: 'Vonage ❤️ Community')

      expect(page).to have_css('h2', text: 'You can find us at these upcoming events')

      within('.Nxd-map-buttons') do
        expect(page).to have_css('label', text: 'Location / Event')
        expect(page).to have_field('searchbox-map', type: 'text')
        expect(page).to have_button('Search')
        expect(page).to have_link('Subscribe to feed', href: 'webcal://www.example.com/feeds/events.ics')
        expect(page).to have_link('View 1 past event', href: '/community/past-events')
      end

      within('#community-events') do
        expect(page).to have_css('h3', text: euruko.title)
        expect(page).to have_link(euruko.title, href: euruko.url)
        expect(page).to have_css('.community-event__date', text: date_range)
        expect(page).to have_content(euruko.description)
      end

      expect(page).to have_css('h2#video-resources', text: 'Video Resources')

      expect(page).to have_css('h4', text: video_session.title)
      expect(page).to have_xpath('.//iframe[@src="https://www.youtube.com/embed/i7EZDYYfFmc?showinfo=0"]')
      expect(page).to have_css('p', text: video_session.description)

      expect(page).to have_css('h2', text: 'Get in touch')
      expect(page).to have_content('Do you have a question or want us to support your tech community event?')
      expect(page).to have_content('Drop us an email at community[at]vonage.com')
      expect(page).to have_link('community[at]vonage.com', href: 'mailto:community@vonage.com')
      expect(page).to have_content('Your data will be treated in accordance with our')
      expect(page).to have_link('Privacy Policy', href: 'https://www.nexmo.com/privacy-policy')
      expect(page).to have_content(', which sets out the rights you have in respect of your data')

      expect(page).to have_css('h2#vonagedev-on-twitter', text: '@VonageDev on Twitter')

      expect(page).to have_content('Join the Vonage Developer Community Slack')
      expect(page).to have_link('Vonage Developer Community Slack', href: '/community/slack')
    end
  end
end
