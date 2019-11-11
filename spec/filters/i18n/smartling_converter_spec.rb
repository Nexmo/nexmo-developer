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
end
