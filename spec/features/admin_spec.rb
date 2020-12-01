require 'spec_helper'

RSpec.feature 'Admin pages', type: :feature do
  given(:admin) { FactoryBot.create(:user, admin: true) }

  background do
    visit '/admin'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Login'
  end

  scenario 'can access the feedback stats page' do
    visit '/stats'

    expect(page).to have_css('h1', text: 'Feedback Stats')
  end

  scenario 'can access the code snippets coverage page' do
    visit '/coverage'

    expect(page).to have_css('h1', text: 'Code Snippet Stats')
  end

  scenario 'can access the feedback page' do
    visit '/admin/feedbacks'

    expect(page).to have_css('h2', text: 'Feedbacks')
  end
end
