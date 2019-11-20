require 'rails_helper'

RSpec.describe DocFinder do
  describe '.build_doc_language' do
    let(:root) { '_documentation' }
    let(:doc)  { '_documentation/conversation/api-reference.md' }

    it 'adds the language to the doc\'s path' do
      expect(described_class.build_doc_path(root, doc, 'en')).to eq('_documentation/en/conversation/api-reference.md')
    end
  end

  describe '.build_key' do
    context 'when the document has file extension' do
      it 'returns the key of the corresponding document' do
        key = described_class.build_key(root: '_documentation', document: 'messages/overview.md')

        expect(key).to eq('_documentation/messages/overview.md')
      end
    end

    context 'otherwise' do
      it 'returns the key of the corresponding document' do
        key = described_class.build_key(root: '_documentation', document: 'messages/overview', format: 'md')

        expect(key).to eq('_documentation/messages/overview.md')
      end
    end
  end

  describe '.find' do
    let(:language) { 'en' }

    subject do
      described_class.find(
        root: root,
        document: document,
        language: language,
        code_language: code_language
      )
    end

    context 'with a code_language' do
      let(:root)          { '_documentation' }
      let(:document)      { 'numbers/code-snippets/list-owned' }
      let(:code_language) { 'ruby' }

      it 'returns the path to the doc' do
        expect(subject).to eq('_documentation/en/numbers/code-snippets/list-owned.md')
      end
    end

    context 'without_one' do
      let(:root)          { 'app/views/product-lifecycle' }
      let(:document)      { 'dev-preview' }
      let(:code_language) { nil }

      it 'returns the path to the doc' do
        expect(subject).to eq('app/views/product-lifecycle/dev-preview.md')
      end
    end
  end

  describe '.linkable_code_language' do
    let(:root)     { '_documentation' }
    let(:document) { 'numbers/code-snippets/list-owned' }
    let(:format)   { 'md' }

    subject do
      described_class.linkable_code_language(
        root: root,
        document: document,
        format: format,
        language: language
      )
    end

    context 'when the document is not available in the given language' do
      let(:language) { 'de' }

      it 'defaults to english' do
        expect(subject).to eq('_documentation/en/numbers/code-snippets/list-owned.md')
      end
    end
  end

  describe '.non_linkable' do
    let(:language) { 'en' }
    let(:format)   { 'md' }

    subject do
      described_class.non_linkable(
        root: root,
        document: document,
        format: format,
        language: language
      )
    end

    context 'looking for a file under app/views' do
      let(:root)     { 'app/views/product-lifecycle' }
      let(:document) { 'dev-preview' }

      it 'returns the path to the file' do
        expect(subject).to eq('app/views/product-lifecycle/dev-preview.md')
      end
    end

    context 'otherwise' do
      let(:root)     { '_documentation' }
      let(:document) { 'messages/external-accounts/overview.md' }

      context 'when the document is not available in the given language' do
        let(:language) { 'de' }

        it 'returns the path to the file in the default language' do
          expect(subject).to eq('_documentation/en/messages/external-accounts/overview.md')
        end
      end
    end
  end
end
