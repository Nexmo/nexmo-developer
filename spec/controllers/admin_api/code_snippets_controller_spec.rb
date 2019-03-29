require 'rails_helper'

RSpec.describe AdminApi::CodeSnippetsController, type: :request do
  before do
    allow_any_instance_of(AdminApiController).to receive(:authenticate).and_return(true)
  end
  describe 'GET #index' do
    context 'with no parameters' do
      it 'retrieves all records when supplied with no params' do
        @events = events_data
        allow(UsageBuildingBlockEvent).to receive_message_chain(:all, :group, :count).and_return(@events)

        get '/admin_api/code_snippets'
        expect(@events.count).to eq(4)
      end
    end

    context 'with block and/or language parameters' do
      it 'retrieves only records matching the language parameter provided' do
        @events = by_language_param
        get '/admin_api/code_snippets?language=PHP'
        allow(UsageBuildingBlockEvent).to receive_message_chain(:where, :group, :count).and_return(@events)
        expect(@events.count).to eq(2)
      end

      it 'retrieves only records matching the block parameter provided' do
        @events = by_block_param
        get '/admin_api/code_snippets?block=voice/make-an-outbound-call'
        allow(UsageBuildingBlockEvent).to receive_message_chain(:where, :group, :count).and_return(@events)
        expect(@events.count).to eq(3)
      end

      it 'retrieves only records matching both block and language parameters provided' do
        @events = by_language_and_block_params
        get '/admin_api/code_snippets?block=voice/make-an-outbound-call&language=Ruby'
        allow(UsageBuildingBlockEvent).to receive_message_chain(:where, :group, :count).and_return(@events)
        expect(@events.count).to eq(1)
      end
    end

    context 'with date parameters' do
      let(:params) do
        {
          'created_after' => '01/01/2019',
          'created_before' => '03/01/2019',
        }
      end
      it 'calls the #created_between method' do
        @events = events_data
        allow(UsageBuildingBlockEvent).to receive_message_chain(:created_between, :group, :count).and_return(@events)

        expect(UsageBuildingBlockEvent).to receive(:created_between).with(params['created_after'], params['created_before'])
        get "/admin_api/code_snippets?created_after=#{params['created_after']}&created_before=#{params['created_before']}"
      end
    end
  end
end

def events_data
  {
    ['voice/make-an-outbound-call', 'cURL', 'code', 'source'] => 1,
    ['voice/make-an-outbound-call', 'PHP', 'code', 'source'] => 1,
    ['voice/make-an-outbound-call', 'PHP', 'code', 'copy'] => 2,
    ['voice/receive-an-inbound-call', 'Ruby', 'code', 'copy'] => 1,
  }
end

def by_language_param
  {
    ['voice/make-an-outbound-call', 'PHP', 'code', 'source'] => 1,
    ['voice/make-an-outbound-call', 'PHP', 'code', 'copy'] => 2,
  }
end

def by_block_param
  {
    ['voice/make-an-outbound-call', 'cURL', 'code', 'source'] => 1,
    ['voice/make-an-outbound-call', 'PHP', 'code', 'source'] => 1,
    ['voice/make-an-outbound-call', 'PHP', 'code', 'copy'] => 2,
  }
end

def by_language_and_block_params
  {
    ['voice/make-an-outbound-call', 'Ruby', 'code', 'copy'] => 1,
  }
end
