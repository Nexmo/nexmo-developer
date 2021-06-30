require 'spec_helper'

RSpec.feature 'Landing page', type: :feature do
  scenario 'visiting the landing page' do
    visit '/'

    within('#subnav') do
      expect(page).to have_link('Documentation', href: '/documentation')
      expect(page).to have_link('Use Cases', href: '/use-cases')
      expect(page).to have_link('SDKs & Tools', href: '/tools')
      expect(page).to have_link('Community', href: '/community')
    end
  end
end
