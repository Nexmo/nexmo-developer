require 'spec_helper'

RSpec.feature 'Smoke Tests', type: :feature do
  scenario '/ contains the expected text' do
    visit '/'

    expect(page).to have_content('Vonage API Developer')
    expect(page).to have_content('Everything you need to build connected applications with Vonage APIs')
  end

  scenario '/documentation contains the expected text' do
    visit '/documentation'

    expect(page).to have_content('Welcome to the Vonage API Developer Documentation')
  end

  scenario '/use-cases contains the expected text' do
    visit '/use-cases'
    expect(page).to have_content('Get started with tutorials that will walk you through building a variety of practical applications')
  end

  scenario '/api contains the expected text' do
    visit '/api'
    expect(page).to have_content('API Reference')
  end

  scenario '/tools contains the expected text' do
    visit '/tools'
    expect(page).to have_content('The Server SDKs allow you to quickly get up and running with the Vonage APIs in your language of choice.')
  end

  scenario '/jwt contains the expected text' do
    visit '/jwt'

    expect(page.status_code).to be(200)
    expect(page).to have_css('#jwt-generator-app')
  end

  scenario '/extend contains the expected text' do
    visit '/extend'
    expect(page).to have_content('The Vonage API Extend Team develops productized integrations so builders everywhere can create better communication experiences for their users.')
  end

  scenario '/extend/ibm-watson-sms-sentiment-analysis contains the expected text' do
    visit '/extend/ibm-watson-sms-sentiment-analysis'
    expect(page).to have_content('This is an application that will return the sentiment of a incoming SMS using Watson')
  end

  scenario '/community contains the expected text' do
    visit '/community'
    expect(page).to have_content('You can find us at these upcoming events')
  end

  scenario '/community/slack contains the expected text' do
    visit '/community/slack'
    expect(page).to have_content('Join the Vonage Developer Community Slack')
  end

  scenario '/legacy contains the expected text' do
    visit '/legacy'
    expect(page).to have_content('Note: This is a deprecated API, you should use')
  end

  scenario '/team contains the expected text' do
    expect(Greenhouse).to receive(:devrel_careers).and_return([])
    visit '/team'
    expect(page).to have_content('Our mission is to build a world-class open source documentation platform to help developers build connected products.')
  end

  scenario 'markdown page contains the expected text' do
    visit '/voice/voice-api/guides/numbers'

    expect(page).to have_content('Numbers are a key concept to understand when working with the Vonage Voice API. The following points should be considered before developing your Vonage Application.')
    expect(page).to have_content('Improve this page')
  end

  scenario 'markdown page has default code_language' do
    visit '/voice/voice-api/code-snippets/connect-an-inbound-call'
    expect(page).to have_css('li.Vlt-tabs__link.Vlt-tabs__link_active[aria-selected="true"][data-language="node"][data-language-type="languages"][data-language-linkable="true"]')
  end

  scenario 'markdown page respects code_language' do
    visit '/voice/voice-api/code-snippets/connect-an-inbound-call/php'

    expect(page).to have_css('li.Vlt-tabs__link.Vlt-tabs__link_active[aria-selected="true"][data-language="php"][data-language-type="languages"][data-language-linkable="true"]')
    expect(page).not_to have_css('li.Vlt-tabs__link.Vlt-tabs__link_active[aria-selected="true"][data-language="node"][data-language-type="languages"][data-language-linkable="true"]')
  end

  scenario '/hansel contains the expected text' do
    visit '/hansel'
    expect(page).to have_content('Welcome, Hanselminutes listeners. Here is everything you need to build your connected applications.')
  end

  scenario '/migrate/tropo contains the expected text' do
    visit '/migrate/tropo'
    expect(page).to have_content('Migrate from Tropo to Nexmo')
  end

  scenario '/migrate/tropo contains the expected text' do
    visit '/migrate/tropo/sms'
    expect(page).to have_content('Convert your SMS code from Tropo to Nexmo')
  end

  # Make sure all landing pages render
  LandingPageConstraint.list.each do |name|
    name = "/#{name}"
    scenario "#{name} loads" do
      allow(Greenhouse).to receive(:devrel_careers).and_return([])
      visit name
    end
  end

  scenario '/api-errors contains the expected text' do
    visit '/api-errors'

    expect(page).to have_content('When a Nexmo API returns an error, for instance, if your account has no credit')
  end

  scenario '/tutorials' do
    visit '/tutorials'

    expect(page.status_code).to be(200)
  end
end
