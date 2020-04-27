require 'rails_helper'

RSpec.feature 'Extend' do
  scenario 'visiting the Extend page' do
    visit '/extend'

    within('.Nxd-landing-main') do
      expect(page).to have_css('h1', text: 'Extend')
      expect(page).to have_css('p', text: 'The Vonage API Extend Team develops productized integrations so builders everywhere can create better communication experiences for their users.')

      within('.Vlt-grid--center') do
        expect(page).to have_css('.Vlt-col', count: 11)

        expect(page).to have_css('h5', text: 'Amazon Lex Connector')
        expect(page).to have_css('p', text: 'A hosted and opensource connector to bridge between Nexmo websockets and Amazon Lex')
        expect(page).to have_link('Learn More', href: '/extend/amazon-lex-connector')

        expect(page).to have_css('h5', text: 'Voicebase Real-time sentiment analysis')
        expect(page).to have_css('p', text: 'Nexmo Websocket application using Voicebase to perform real-time transcription and sentiment analysis')
        expect(page).to have_link('Learn More', href: '/extend/voicebase-real-time-sentiment-analysis')

        expect(page).to have_css('h5', text: 'Converse.ai')
        expect(page).to have_css('p', text: 'Nexmo plugin allows users to build and host IVR (Interactive Voice Response) systems with in Converse platform and handle SMS messages.')
        expect(page).to have_link('Learn More', href: '/extend/converse-ai')

        expect(page).to have_css('h5', text: 'Nexmo Node-RED')
        expect(page).to have_css('p', text: 'A package for the Node-RED Flow Based Programming platform')
        expect(page).to have_link('Learn More', href: '/extend/nodered')

        expect(page).to have_css('h5', text: 'Microsoft Azure Speech To Text')
        expect(page).to have_css('p', text: 'Sample of Azure speech transcribing audio from a call in realtime.')
        expect(page).to have_link('Learn More', href: '/extend/azure-speech-to-text')

        expect(page).to have_css('h5', text: 'Answering Machine detection with machine learning.')
        expect(page).to have_css('p', text: 'Building a VAPI application that sends Text-To-Speech when an answering machine is detected.')
        expect(page).to have_link('Learn More', href: '/extend/answering-machine-detection')

        expect(page).to have_css('h5', text: 'Nexmo Send SMS Action')
        expect(page).to have_css('p', text: 'A GitHub Action for sending an SMS.')
        expect(page).to have_link('Learn More', href: '/extend/nexmo-sms-action')

        expect(page).to have_css('h5', text: 'Microsoft Flow')
        expect(page).to have_css('p', text: 'Add communications within the context of your applications, including SMS, Voice and Chat.')
        expect(page).to have_link('Learn More', href: '/extend/microsoft-flow')

        expect(page).to have_css('h5', text: 'Google Cloud Speech Transcription')
        expect(page).to have_css('p', text: 'Sample of Google Cloud speech transcribing audio from a call in realtime, supports 120 language/dialects')
        expect(page).to have_link('Learn More', href: '/extend/google-transcription')

        expect(page).to have_css('h5', text: 'IBM Watson Speech to Text')
        expect(page).to have_css('p', text: 'Sample of Watson speech transcribing audio from a call in realtime.')
        expect(page).to have_link('Learn More', href: '/extend/ibm-watson-speech-to-text')

        expect(page).to have_css('h5', text: 'IBM Watson SMS Sentiment Analysis')
        expect(page).to have_css('p', text: 'Read incoming SMS messages and have IBM Watson to analyze the messages')
        expect(page).to have_link('Learn More', href: '/extend/ibm-watson-sms-sentiment-analysis')
      end
    end
  end
end
