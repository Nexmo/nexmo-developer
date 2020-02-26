require 'rails_helper'

RSpec.describe IconFilter do
  it 'turns ✅ symbol into HTML' do
    input = <<~HEREDOC
      ✅
    HEREDOC

    expected_output = <<~HEREDOC
      <svg class="Vlt-green Vlt-icon Vlt-icon--small"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-check" /></svg>
    HEREDOC

    expect(described_class.call(input)).to eq(expected_output)
  end
  it 'turns ❌ symbol into HTML' do
    input = <<~HEREDOC
      ❌
    HEREDOC

    expected_output = <<~HEREDOC
      <svg class="Vlt-red Vlt-icon Vlt-icon--small"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-cross" /></svg>
    HEREDOC

    expect(described_class.call(input)). to eq(expected_output)
  end
  it 'turns an icon text reference into the appropriate HTML tag' do
    input = <<~HEREDOC
      [icon="heart"]
    HEREDOC

    expected_output = <<~HEREDOC
      <svg class="Vlt-green Vlt-icon Vlt-icon--small"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-heart" /></svg>\n
    HEREDOC

    expect(described_class.call(input)). to eq(expected_output)
  end
end
