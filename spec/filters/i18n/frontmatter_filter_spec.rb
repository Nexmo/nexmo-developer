require 'rails_helper'

RSpec.describe I18n::FrontmatterFilter do
  let(:frontmatter) do
    <<~FRONTMATTER
      ---
      title: Overview
      meta_title: Send messages via SMS, WhatsApp, Viber and Facebook Messenger
      navigation_weight: 1
      ---
    FRONTMATTER
  end

  it 'escapes the keys with codeblocks since they are ignored by smartling' do
    escaped = described_class.call(frontmatter)
    expect(escaped).to eq(
      <<~FRONTMATTER
        ---
        ```title:``` Overview
        ```meta_title:``` Send messages via SMS, WhatsApp, Viber and Facebook Messenger
        ```navigation_weight:``` 1
        ---
      FRONTMATTER
    )
  end
end
