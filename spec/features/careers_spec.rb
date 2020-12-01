require 'spec_helper'

RSpec.feature 'Careers page', type: :feature do
  given(:career) do
    Career.new(
      title: 'Developer Advocate',
      location: { name: 'Remote' },
      content: 'This is some example content',
      absolute_url: 'https://boards.greenhouse.io/vonage/jobs/123',
      departments: [{ id: 4019724002, name: 'Inside Sales' }]
    )
  end

  scenario 'renders the page' do
    expect(Greenhouse).to receive(:careers).and_return([career])
    expect(Greenhouse).to receive(:offices).and_return([])
    visit '/careers'

    expect(page).to have_css('h1', text: 'Careers')
    expect(page).to have_css('#department-filter')
    expect(page).to have_css('#location-filter')
    expect(page).to have_css('#careers')
  end
end
