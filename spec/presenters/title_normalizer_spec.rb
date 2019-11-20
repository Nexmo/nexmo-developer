require 'rails_helper'

RSpec.describe TitleNormalizer do
  describe '.call' do
    context 'with a file' do
      context 'without :navigation in its frontmatter' do
        let(:path) { '_documentation/en/messages/external-accounts/overview.md' }

        it 'returns the :title defined in the frontmatter' do
          expect(described_class.call({ is_file?: true, path: path })).to eq('Overview')
        end
      end
    end

    context 'with a task' do
      it 'returns its title' do
        expect(described_class.call({ is_task?: true, title: 'title!' })).to eq('title!')
      end
    end

    context 'otherwise' do
      it 'returns the translation of the title' do
        expect(described_class.call({ title: 'dispatch' })).to eq('Dispatch API')
      end
    end
  end
end
