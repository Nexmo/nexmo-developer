require 'rails_helper'

RSpec.describe SmartlingAPI do
  let(:file)     { '_documentation/en/messages/overview.md' }
  let(:file_api) { instance_spy(Smartling::File) }
  let(:file_uri) { 'messages/overview.md' }
  let(:locale)   { 'cn' }

  let(:smartling_api) do
    described_class.new(
      user_id: 'USER_ID',
      user_secret: 'USER_SECRET',
      project_id: 'PROJECT_ID'
    )
  end

  before { allow(Smartling::File).to receive(:new) { file_api } }

  describe '#upload' do
    it 'uploads a file to smartling' do
      smartling_api.upload(file)

      expect(file_api).to have_received(:upload)
        .with(
          kind_of(String),
          file_uri,
          'markdown',
          'smartling.markdown_code_notranslate': true
        )
    end
  end

  describe '#last_modified' do
    it 'checks for the last date a file was modified for a given locale' do
      smartling_api.last_modified(filename: file, locale: locale)

      expect(file_api).to have_received(:last_modified).with(file_uri, locale)
    end
  end

  describe '#download_translated' do
    it 'downloads the file in the provided locale' do
      expect(File).to receive(:open)
        .with("#{Rails.configuration.docs_base_path}/_documentation/cn/messages/overview.md", 'w+')
        .and_return('')
      smartling_api.download_translated(filename: file, locale: locale)

      expect(file_api).to have_received(:download_translated)
        .with(file_uri, locale, retrievalType: :published)
    end
  end
end
