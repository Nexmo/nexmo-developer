require 'rails_helper'

RSpec.describe AdminApi::CodeSnippetsController, type: :request do
  before do
    allow_any_instance_of(AdminApiController).to receive(:authenticate).and_return(true)
  end
  describe 'GET #index' do
    it 'retrieves all records when supplied with no params' do
      @events = events_data
      allow(UsageBuildingBlockEvent).to receive_message_chain(:all, :group, :count).and_return(@events)

      get '/admin_api/code_snippets'
      expect(@events.count).to eq(3)
    end

    it 'retrieves only records matching the language parameter provided' do
      @events = only_php
      get '/admin_api/code_snippets?language=PHP'
      allow(UsageBuildingBlockEvent).to receive_message_chain(:where, :group, :count).and_return(@events)
      expect(@events.count).to eq(2)
    end
  end
end

def events_data
  {
    ['voice/make-an-outbound-call', 'cURL', 'code', 'source'] => 1,
    ['voice/make-an-outbound-call', 'PHP', 'code', 'source'] => 1,
    ['voice/make-an-outbound-call', 'PHP', 'code', 'copy'] => 2,
  }
end

def only_php
  {
    ['voice/make-an-outbound-call', 'PHP', 'code', 'source'] => 1,
    ['voice/make-an-outbound-call', 'PHP', 'code', 'copy'] => 2,
  }
end
