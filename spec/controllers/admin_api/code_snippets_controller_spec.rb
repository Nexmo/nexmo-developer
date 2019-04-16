require 'rails_helper'

RSpec.describe AdminApi::CodeSnippetsController, type: :request do
  before do
    allow_any_instance_of(AdminApiController).to receive(:authenticate).and_return(true)
  end

  describe 'GET #index' do
    context '#organize_data' do
      it 'formats the response correctly' do
        allow(Usage::CodeSnippetEvent).to receive_message_chain(:all, :group, :count).and_return(events_data)

        get '/admin_api/code_snippets'

        expect(JSON.parse(response.body)).to eq({
         'voice/make-an-outbound-call' => {
            'PHP' => {
              'code' => {
                'copy' => 2,
                'source' => 1,
              },
            },
            'cURL' => {
              'code' => {
                'source' => 1,
              },
            },
          },
         'voice/receive-an-inbound-call' => {
            'Ruby' => {
              'code' => {
                'copy' => 1,
              },
            },
          },
        })
      end
    end

    context 'with no parameters' do
      it 'calls .group then .chain (and implicitly .all)' do
        expect(Usage::CodeSnippetEvent).to receive_message_chain(:group, :count).and_return([])
        get '/admin_api/code_snippets'
      end
    end

    context 'with filter parameters' do
      it 'searches by language if it is the only parameter' do
        expect(Usage::CodeSnippetEvent).to receive(:where).with(['language = :language', hash_including({ language: 'PHP' })])
        allow(Usage::CodeSnippetEvent).to receive_message_chain(:where, :group, :count).and_return([])

        get '/admin_api/code_snippets?language=PHP'
      end

      it 'searches by snippet if it is the only parameter' do
        expect(Usage::CodeSnippetEvent).to receive(:where).with(['snippet = :snippet', hash_including({ snippet: 'voice/make-an-outbound-call' })])
        allow(Usage::CodeSnippetEvent).to receive_message_chain(:where, :group, :count).and_return([])

        get '/admin_api/code_snippets?snippet=voice/make-an-outbound-call'
      end

      it 'searches with snippet and language if both are provided' do
        expect(Usage::CodeSnippetEvent).to receive(:where).with(['snippet = :snippet and language = :language', hash_including({ snippet: 'voice/receive-an-inbound-call', language: 'Ruby' })])
        allow(Usage::CodeSnippetEvent).to receive_message_chain(:where, :group, :count).and_return([])

        get '/admin_api/code_snippets?snippet=voice/receive-an-inbound-call&language=Ruby'
      end
    end

    context 'with date parameters' do
      let(:created_after) { '01/01/2019' }
      let(:created_before) { '03/01/2019' }

      it 'passes through both created_after and created_before' do
        expect(Usage::CodeSnippetEvent).to receive(:created_between).with(created_after, created_before)
        allow(Usage::CodeSnippetEvent).to receive_message_chain(:created_between, :group, :count).and_return([])
        get "/admin_api/code_snippets?created_after=#{created_after}&created_before=#{created_before}"
      end

      it 'passes through only created_after' do
        expect(Usage::CodeSnippetEvent).to receive(:created_between).with(created_after, nil)
        allow(Usage::CodeSnippetEvent).to receive_message_chain(:created_between, :group, :count).and_return([])
        get "/admin_api/code_snippets?created_after=#{created_after}"
      end

      it 'passes through only created_before' do
        expect(Usage::CodeSnippetEvent).to receive(:created_between).with(nil, created_before)
        allow(Usage::CodeSnippetEvent).to receive_message_chain(:created_between, :group, :count).and_return([])
        get "/admin_api/code_snippets?created_before=#{created_before}"
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
