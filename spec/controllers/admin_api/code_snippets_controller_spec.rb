require 'rails_helper'

RSpec.describe AdminApi::CodeSnippetsController, :type => :request do
  before do
    Rails.application.routes.draw do
      namespace :admin_api, defaults: { format: 'json' } do
        resources :code_snippets, only: [:index]
      end
    end
  end
  after do
    Rails.application.reload_routes!
  end

  describe 'GET #index' do
    it 'retrieves all records when supplied with no params' do
      @events = allow(UsageBuildingBlockEvent).to receive(:all).and_return([first_event, second_event, third_event])
      puts response
    end
  end
end

def first_event
  {
    'language' => 'Ruby',
    'block' => 'voice/make-an-outbound-call',
    'section' => 'code',
    'action' => 'source',
    'created_at' => '2019-01-01 12:00:00'
  }
end

def second_event
  {
    'language' => 'PHP',
    'block' => 'voice/receive-an-inbound-call',
    'section' => 'code',
    'action' => 'copy',
    'created_at' => '2019-02-01 12:00:00'
  }
end

def third_event
  {
    'language' => 'Ruby',
    'block' => 'voice/make-an-outbound-call',
    'section' => 'code',
    'action' => 'copy',
    'created_at' => '2018-12-01 12:00:00'
  }
end