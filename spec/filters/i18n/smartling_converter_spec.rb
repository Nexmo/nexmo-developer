require 'rails_helper'

RSpec.describe I18n::SmartlingConverterFilter do
  let(:frontmatter) do
    <<~FRONTMATTER
      *** ** * ** ***

      `title:` Before you begin
      `navigation_weight:` 0
      ------------------------------------------
    FRONTMATTER
  end

  it 'translates the frontmatter to yaml' do
    translated = described_class.call(frontmatter)
    expect(translated).to eq(
      <<~FRONTMATTER
        ---
        title: Before you begin
        navigation_weight: 0

        ---

      FRONTMATTER
    )
  end

  context 'revert some encodings from smartling' do
    let(:table) do
      <<~TABLE
        密钥 \| 说明
        \-\- \| \-\-
        `NEXMO_API_KEY` \| 您的 Nexmo API 密钥。
        `NEXMO_API_SECRET` \| 您的 Nexmo API 密码。
      TABLE
    end

    it 'unescapes some special characters' do
      translated = described_class.call(table)
      expect(translated).to include(
        <<~TABLE
          密钥 | 说明
          -- | --
          `NEXMO_API_KEY` | 您的 Nexmo API 密钥。
          `NEXMO_API_SECRET` | 您的 Nexmo API 密码。
        TABLE
      )
    end
  end
end
