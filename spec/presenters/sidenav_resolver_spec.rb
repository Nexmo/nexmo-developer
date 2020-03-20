require 'rails_helper'

RSpec.describe SidenavResolver do
  let(:path)      { "#{Rails.configuration.docs_base_path}/_documentation" }
  let(:language)  { 'en' }
  let(:namespace) { nil }

  subject do
    described_class.new(
      path: path,
      language: language,
      namespace: namespace
    )
  end

  describe '#items' do
    context 'with a view path' do
      let(:path) { 'app/views/product-lifecycle' }

      it 'returns the files under the path' do
        expect(subject.items.size).to eq(2)
      end
    end

    context 'with a document path' do
      it 'returns the files under the path' do
        expect(subject.items.size).to eq(17)
      end
    end
  end

  describe '#directories' do
    let(:path) { 'app/views/product-lifecycle' }

    it 'returns a sorted array with all markdown files in the provided path' do
      result = subject.directories(path)

      expect(result[:title]).to eq('app/views/product-lifecycle')
      expect(result[:path]).to eq('app/views/product-lifecycle')
      expect(result[:children]).to eq(
        [
          { title: 'dev-preview.md', is_file?: true, path: "#{path}/dev-preview.md" },
          { title: 'beta.md', is_file?: true, path: "#{path}/beta.md" },
        ]
      )
    end
  end

  describe '#url_to_configuration_identifier' do
    it 'replaces / with .' do
      expect(subject.url_to_configuration_identifier('/text/to/replace')).to eq('.text.to.replace')
    end
  end

  describe '#strip_namespace' do
    it 'removes the root and language from the path' do
      expect(subject.strip_namespace('_documentation/en/messaging/sms/overview.md')).to eq('messaging/sms/overview.md')
    end
  end

  describe '#path_to_url' do
    it 'removes the root, language and extension' do
      expect(subject.path_to_url('_documentation/en/messaging/sms/overview.md')).to eq('messaging/sms/overview')
    end
  end

  describe '#item_navigation_weight' do
    context 'with given navigation weight' do
      it 'returns the corresponding one' do
        item = { is_task?: true, title: 'messages' }
        expect(subject.item_navigation_weight(item)).to eq(1)
      end
    end

    context 'without a navigation weight' do
      it 'returns the default one' do
        item = { is_task?: true, title: 'default' }
        expect(subject.item_navigation_weight(item)).to eq(1000)
      end
    end
  end

  describe '#navigation_weight_from_meta' do
    context 'when it is a file' do
      it 'returns 1000' do
        item = { is_file?: false }
        expect(subject.navigation_weight_from_meta(item)).to eq(1000)
      end
    end

    context 'otherwise' do
      it 'returns the corresponding weight' do
        item = { is_file?: true, path: '/en/messages/external-accounts/overview.md' }
        expect(subject.navigation_weight_from_meta(item)).to eq(1)
      end
    end
  end

  describe '#document_meta' do
    let(:doc_path) { '/en/messages/external-accounts/overview.md' }

    it 'finds the document and returns its frontmatter' do
      frontmatter = subject.document_meta(root: "#{Rails.configuration.docs_base_path}/_documentation", path: doc_path)

      expect(frontmatter['title']).to eq('Overview')
      expect(frontmatter['meta_title']).to eq('Connect external services to your Nexmo account for the Messages API')
      expect(frontmatter['navigation_weight']).to eq(1)
    end
  end

  describe '#sort_navigation' do
    let(:structure) do
      {
        title: '_documentation/en',
        path: '_documentation/en',
        children: [
          { title: 'account',               path: '_documentation/en/account' },
          { title: 'application',           path: '_documentation/en/application' },
          { title: 'audit',                 path: '_documentation/en/audit' },
          { title: 'dispatch',              path: '_documentation/en/dispatch' },
          { title: 'voice',                 path: '_documentation/en/voice' },
          { title: 'client-sdk',            path: '_documentation/en/client-sdk' },
          { title: 'concepts',              path: '_documentation/en/concepts' },
          { title: 'conversation',          path: '_documentation/en/conversation' },
          { title: 'messaging',             path: '_documentation/en/messaging' },
          { title: 'messages',              path: '_documentation/en/messages' },
          { title: 'number-insight',        path: '_documentation/en/number-insight' },
          { title: 'numbers',               path: '_documentation/en/numbers' },
          { title: 'verify',                path: '_documentation/en/verify' },
          { title: 'vonage-business-cloud', path: '_documentation/en/vonage-business-cloud' },
          { title: 'redact',                path: '_documentation/en/redact' },
          { title: 'reports',               path: '_documentation/en/reports' },
        ],
      }
    end

    it 'sorts the items based on their weight' do
      result = subject.sort_navigation(structure)
      items = result[:children].map { |child| child[:title] }

      expect(items).to match_array(
        [
          'concepts',
          'application',
          'messages',
          'messaging',
          'dispatch',
          'voice',
          'verify',
          'number-insight',
          'conversation',
          'client-sdk',
          'numbers',
          'account',
          'audit',
          'redact',
          'reports',
          'vonage-business-cloud',
        ]
      )
    end
  end
end
