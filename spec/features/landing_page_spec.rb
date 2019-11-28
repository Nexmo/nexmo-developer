require 'rails_helper'

RSpec.feature 'Landing page' do
  scenario 'visiting the landing page' do
    visit '/'

    within('#subnav') do
      expect(page).to have_link('Documentation', href: '/documentation')
      expect(page).to have_link('Use Cases', href: '/use-cases')
      expect(page).to have_link('API Reference', href: '/api')
      expect(page).to have_link('SDKs & Tools', href: '/tools')
      expect(page).to have_link('Community', href: '/community')
      expect(page).to have_link('Extend', href: '/extend')
    end

    within('.container .row .center', match: :first) do
      expect(page).to have_css('h1.Vlt-title--margin-top2', text: 'Connected Code')
      expect(page).to have_css('p.p-large', text: 'Everything you need to build connected applications with Nexmo')
    end

    within('.container .columns.small-12') do
      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(1)') do
        expect(page).to have_css('small', text: 'Send and receive')
        expect(page).to have_link('SMS', href: '/messaging/sms/overview')

        within('nav') do
          expect(page).to have_link('Overview', href: '/messaging/sms/overview')
          expect(page).to have_link('Guides', href: '/messaging/sms/guides')
          expect(page).to have_link('Code Snippets', href: '/messaging/sms/code-snippets')
          expect(page).to have_link('Tutorials', href: '/messaging/sms/tutorials')
          expect(page).to have_link('API Reference', href: '/api/sms')
        end
      end

      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(2)') do
        expect(page).to have_css('small', text: 'Programmable')
        expect(page).to have_link('Voice', href: '/voice/overview')

        within('nav') do
          expect(page).to have_link('Overview', href: '/voice/')
          expect(page).to have_link('Guides', href: '/voice/guides')
          expect(page).to have_link('Code Snippets', href: '/voice/code-snippets')
          expect(page).to have_link('Tutorials', href: '/voice/voice-api/tutorials')
          expect(page).to have_link('API Reference', href: '/api/voice')
          expect(page).to have_link('NCCO Reference', href: '/voice/voice-api/ncco-reference')
        end
      end

      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(3)') do
        expect(page).to have_css('small', text: 'Programmable')
        expect(page).to have_link('Video', href: 'https://tokbox.com/developer/')

        within('nav') do
          expect(page).to have_link('Overview', href: 'https://tokbox.com/developer/guides/basics/')
          expect(page).to have_link('Guides', href: 'https://tokbox.com/developer/guides/')
          expect(page).to have_link('Code Snippets', href: 'https://tokbox.com/developer/samples/')
          expect(page).to have_link('Tutorials', href: 'https://tokbox.com/developer/tutorials/')
          expect(page).to have_link('API Reference', href: 'https://tokbox.com/developer/sdks/client/')
        end
      end

      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(4)') do
        expect(page).to have_css('small', text: 'User Authentication')
        expect(page).to have_link('Verify', href: '/verify/overview')

        within('nav') do
          expect(page).to have_link('Overview', href: '/verify/overview')
          expect(page).to have_link('Guides', href: '/verify/guides')
          expect(page).to have_link('Code Snippets', href: '/verify/code-snippets')
          expect(page).to have_link('Tutorials', href: '/verify/tutorials')
          expect(page).to have_link('API Reference', href: '/api/verify')
        end
      end

      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(5)') do
        expect(page).to have_css('small', text: 'User Identity')
        expect(page).to have_link('Number Insight', href: '/number-insight/overview')

        within('nav') do
          expect(page).to have_link('Overview', href: '/number-insight/overview')
          expect(page).to have_link('Guides', href: '/number-insight/guides')
          expect(page).to have_link('Code Snippets', href: '/number-insight/code-snippets')
          expect(page).to have_link('Tutorials', href: '/number-insight/tutorials')
          expect(page).to have_link('API Reference', href: '/api/number-insight')
        end
      end

      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(6)') do
        expect(page).to have_css('small', text: 'Programmable Conversations')
        expect(page).to have_link('Conversation API', href: '/conversation/overview')

        within('nav') do
          expect(page).to have_link('Overview', href: '/conversation/overview')
          expect(page).to have_link('Concepts', href: '/conversation/concepts/conversation')
          expect(page).to have_link('Code Snippets', href: '/conversation/code-snippets/conversation/list-conversations')
          expect(page).to have_link('Tutorials', href: '/conversation/use-cases')
          expect(page).to have_link('API Reference', href: '/api/conversation')
        end
      end

      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(7)') do
        expect(page).to have_css('small', text: 'Configure')
        expect(page).to have_link('Applications', href: '/application/overview')

        within('nav') do
          expect(page).to have_link('Overview', href: '/application/overview')
          expect(page).to have_link('Concepts', href: '/application/overview')
          expect(page).to have_link('Code Snippets', href: '/application/code-snippets')
          expect(page).to have_link('API Reference', href: '/api/application.v2')
        end
      end

      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(8)') do
        expect(page).to have_css('small', text: 'Management')
        expect(page).to have_link('Account', href: '/account/overview')

        within('nav') do
          expect(page).to have_link('Overview', href: '/account/overview')
          expect(page).to have_link('Guides', href: '/account/guides')
          expect(page).to have_link('Code Snippets', href: '/account/code-snippets')
          expect(page).to have_link('API Reference', href: '/api/account')
        end
      end

      within('.Vlt-col.Vlt-col--1of3.Vlt-col--M-1of2:nth-of-type(9)') do
        expect(page).to have_css('h2', text: 'Management APIs')
        within('nav:nth-of-type(1)') do
          expect(page).to have_link('Message Search', href: '/api/developer/messages')
          expect(page).to have_link('Numbers', href: '/api/developer/numbers')
          expect(page).to have_link('Pricing', href: '/api/developer/pricing')
          expect(page).to have_link('Conversion', href: '/api/conversion')
          expect(page).to have_link('Media', href: '/api/media')
          expect(page).to have_link('Redact', href: '/api/redact')
          expect(page).to have_link('Secret Management', href: '/api/account/secret-management')
        end
      end

      within('.Nxd-products-banner:nth-of-type(1)') do
        expect(page).to have_link('Messages and Dispatch Beta', href: '/messages/overview')
        expect(page).to have_css('p', text: 'Integrate with various communication channels including Facebook Messenger, WhatsApp and Viber with failover')
      end

      within('.Vlt-grid.Vlt-grid--center:nth-of-type(3)') do
        within('.Vlt-col--M-1of2:nth-of-type(1)') do
          expect(page).to have_css('small', text: 'One API, multiple channels')
          expect(page).to have_link('Messages', href: '/messages/overview')

          within('nav') do
            expect(page).to have_link('Overview', href: '/messages/overview')
            expect(page).to have_link('Concepts', href: '/messages/concepts')
            expect(page).to have_link('Code Snippets', href: '/messages/code-snippets')
            expect(page).to have_link('Tutorials', href: '/messages/tutorials')
            expect(page).to have_link('API Reference', href: '/api/messages-olympus')
          end
        end

        within('.Vlt-col--M-1of2:nth-of-type(2)') do
          expect(page).to have_css('small', text: 'Orchestrate messages with failover')
          expect(page).to have_link('Dispatch', href: '/dispatch/overview')

          within('nav') do
            expect(page).to have_link('Overview', href: '/dispatch/overview')
            expect(page).to have_link('Concepts', href: '/dispatch/concepts')
            expect(page).to have_link('Code Snippets', href: '/dispatch/code-snippets')
            expect(page).to have_link('Tutorials', href: '/dispatch/tutorials')
            expect(page).to have_link('API Reference', href: '/api/dispatch')
          end
        end
      end

      within('.Nxd-products-banner:nth-of-type(2)') do
        expect(page).to have_link('Nexmo Client SDK - Beta', href: '/client-sdk/overview')
        expect(page).to have_css('p', text: 'Build multi-platform applications with contextual communications using Nexmo Client SDK and Conversation API.')
      end

      within('.Vlt-grid.Vlt-grid--center:nth-of-type(5)') do
        within('.Vlt-col--M-1of2:nth-of-type(1)') do
          expect(page).to have_css('small', text: 'Nexmo Client SDK')
          expect(page).to have_link('In-App Voice', href: '/client-sdk/in-app-voice/overview')

          within('nav') do
            expect(page).to have_link('Overview', href: '/client-sdk/in-app-voice/overview')
            expect(page).to have_link('Concepts', href: '/client-sdk/in-app-voice/overview#concepts')
            expect(page).to have_link('Setup', href: '/client-sdk/setup/create-your-application')
            expect(page).to have_link('Getting Started', href: '/client-sdk/in-app-voice/getting-started/app-to-app-call')
            expect(page).to have_link('Tutorials', href: '/client-sdk/tutorials')
            expect(page).to have_link('Use Cases', href: '/client-sdk/use-cases')
            expect(page).to have_link('Conversation API Reference', href: '/api/conversation')
            expect(page).to have_link('SDK Reference - Android', href: '/client-sdk/sdk-documentation/android')
            expect(page).to have_link('SDK Reference - iOS', href: '/client-sdk/sdk-documentation/ios')
            expect(page).to have_link('SDK Reference - JavaScript', href: '/client-sdk/sdk-documentation/javascript')
          end
        end

        within('.Vlt-col--M-1of2:nth-of-type(2)') do
          expect(page).to have_css('small', text: 'Nexmo Client SDK')
          expect(page).to have_link('In-App Messaging', href: '/client-sdk/in-app-messaging/overview')

          within('nav') do
            expect(page).to have_link('Overview', href: '/client-sdk/in-app-messaging/overview')
            expect(page).to have_link('Concepts', href: '/client-sdk/in-app-messaging/concepts')
            expect(page).to have_link('Tutorials', href: '/client-sdk/tutorials')
            expect(page).to have_link('Use Cases', href: '/client-sdk/use-cases')
            expect(page).to have_link('Conversation API Reference', href: '/api/conversation')
            expect(page).to have_link('SDK Reference - Android', href: '/client-sdk/sdk-documentation/android')
            expect(page).to have_link('SDK Reference - iOS', href: '/client-sdk/sdk-documentation/ios')
            expect(page).to have_link('SDK Reference - JavaScript', href: '/client-sdk/sdk-documentation/javascript')
          end
        end
      end

      within('.Vlt-grid:nth-of-type(6)') do
        within('.Vlt-col--M-1of2:nth-of-type(1)') do
          expect(page).to have_link('SDKs & Tools', href: '/tools')
          expect(page).to have_content('The Nexmo libraries allow you to get up and running with')
          expect(page).to have_content('Nexmo APIs quickly in your language of choice.')
        end

        within('.Vlt-col--M-1of2:nth-of-type(2)') do
          expect(page).to have_link('Community', href: '/community')
          expect(page).to have_content('Find out about our talks, community hacks,')
          expect(page).to have_content('and what events we\'ll be at.')
        end
      end
    end
  end
end
