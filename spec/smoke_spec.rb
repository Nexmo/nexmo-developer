require 'rails_helper'

RSpec.describe 'Smoke Tests', type: :request do
  it '/ contains the expected text' do
    get '/'
    expect(response.body).to include('Connected Code')
    expect(response.body).to include('Everything you need to build connected applications with Nexmo')
  end

  it '/documentation contains the expected text' do
    get '/documentation'
    expect(response.body).to include('Welcome to the Nexmo Developer Documentation')
  end

  it '/tutorials contains the expected text' do
    get '/tutorials'
    expect(response.body).to include('Get started with Nexmo with tutorials that will walk you through building a variety of practical applications')
  end

  it '/api contains the expected text' do
    get '/api'
    expect(response.body).to include('API Reference')
  end

  it '/tools contains the expected text' do
    get '/tools'
    expect(response.body).to include('The Nexmo Server SDKs allow you to get up an running with Nexmo API quickly in your language of choice.')
  end

  it '/extend contains the expected text' do
    get '/extend'
    expect(response.body).to include('The Nexmo Extend Team develops productized integrations so builders everywhere can create better communication experiences for their users.')
  end

  it '/extend/ibm-watson-sms-sentiment-analysis contains the expected text' do
    get '/extend/ibm-watson-sms-sentiment-analysis'
    expect(response.body).to include('This is an application that will return the sentiment of a incoming SMS using Watson')
  end

  it '/community contains the expected text' do
    get '/community'
    expect(response.body).to include('You can find us at these upcoming events')
  end

  it '/community/slack contains the expected text' do
    get '/community/slack'
    expect(response.body).to include('Join the Nexmo Community Slack')
  end

  it '/contribute redirects' do
    get '/contribute'
    expect(response.body).to include('<html><body>You are being <a href="http://www.example.com/contribute/overview">redirected</a>.</body></html>')
  end

  it '/contribute/overview contains the expected text' do
    get '/contribute/overview'
    expect(response.body).to include('We\'re always looking at ways to improve our documentation and platform and would love to invite you to contribute your suggestions not only to the content but also the open-source platform that it is built upon.')
  end

  it '/contribute/guides/writing-style-guide contains the expected text' do
    get '/contribute/guides/writing-style-guide'
    expect(response.body).to include('These are technical writing guidelines that can be used across all Nexmo technical documentation as well as blog posts.')
  end

  it '/legacy contains the expected text' do
    get '/legacy'
    expect(response.body).to include('Note: This is a deprecated API, you should use')
  end

  it '/team contains the expected text' do
    get '/team'
    expect(response.body).to include('Our mission is to build a world-class open source documentation platform to help developers build connected products.')
  end

  it '/team/technical-lead-developer-experience contains the expected text' do
    career = Career.new({
      title: 'Ruby on Rails Technical Lead',
      published: true,
      location: 'Remote',
      description: 'This is a test description',
    })

    expect(Career).to receive_message_chain(:friendly, :find).with('technical-lead-developer-experience').and_return(career)
    get '/team/technical-lead-developer-experience'
    expect(response.body).to include('Ruby on Rails Technical Lead')
    expect(response.body).to include('This is a test description')
  end

  it 'markdown page contains the expected text' do
    get '/voice/voice-api/guides/numbers'
    expect(response.body).to include('Numbers are a key concept to understand when working with the Nexmo Voice API. The following points should be considered before developing your Nexmo Application.')
  end

  it 'markdown page has default code_language' do
    get '/voice/voice-api/code-snippets/connect-an-inbound-call'
    expect(response.body).to include('li class="Vlt-tabs__link Vlt-tabs__link_active" aria-selected="true" data-language="node" data-language-type="languages" data-language-linkable="true"')
  end

  it 'markdown page respects code_language' do
    get '/voice/voice-api/code-snippets/connect-an-inbound-call/php'
    expect(response.body).to include('li class="Vlt-tabs__link Vlt-tabs__link_active" aria-selected="true" data-language="php" data-language-type="languages" data-language-linkable="true"')
    expect(response.body).not_to include('li class="Vlt-tabs__link Vlt-tabs__link_active" aria-selected="true" data-language="node" data-language-type="languages" data-language-linkable="true"')
  end

  it '/hansel contains the expected text' do
    get '/hansel'
    expect(response.body).to include('Welcome, Hanselminutes listeners. Here is everything you need to build your connected applications.')
  end

  it '/spotlight contains the expected text' do
    get '/spotlight'
    expect(response.body).to include('We\'re interested in both technical tutorials and general pieces on programming. Successful submissions will be')
  end

  it '/migrate/tropo contains the expected text' do
    get '/migrate/tropo'
    expect(response.body).to include('Migrate from Tropo to Nexmo')
  end

  it '/migrate/tropo contains the expected text' do
    get '/migrate/tropo/sms'
    expect(response.body).to include('Convert your SMS code from Tropo to Nexmo')
  end

  it '/api-errors contains the expected text' do
    get '/api-errors'
    expect(response.body).to include('When a Nexmo API returns an error, for instance, if your account has no credit')
  end

  it '/product-lifecycle/beta contains the expected text' do
    get '/product-lifecycle/beta'
    expect(response.body).to include('Beta products at Nexmo are in the final stages of testing')
  end
end
