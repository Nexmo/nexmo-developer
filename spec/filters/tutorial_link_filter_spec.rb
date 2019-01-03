require 'rails_helper'

RSpec.describe TutorialLinkFilter do
  it 'returns unaltered non-href input' do
    input = 'this is some input'

    expected_output = 'this is some input'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns unaltered href input not beginning with "/tutorials/"' do
    input = '<a href="/a/path/to/somewhere/">this is a path</a>'

    expected_output = '<a href="/a/path/to/somewhere/">this is a path</a>'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'adds "data-turbolinks=false" to href input beginning with "/tutorials/"' do
    input = '<a href="/tutorials/a_tutorial">a tutorial</a>'

    expected_output = '<a href="/tutorials/a_tutorial" data-turbolinks="false">a tutorial</a>'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'returns unaltered href input with "/tutorials" not at the beginning' do
    input = '<a href="/a/path/to/tutorials/">this is a path</a>'

    expected_output = '<a href="/a/path/to/tutorials/">this is a path</a>'

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'applies the modification to two matching href links' do
    input = <<~HEREDOC
      <a href="/tutorials/one/">first tutorial</a>
      <a href="/tutorials/two/">second tutorial</a>
    HEREDOC

    expected_output = <<~HEREDOC
      <a href="/tutorials/one/" data-turbolinks="false">first tutorial</a>
      <a href="/tutorials/two/" data-turbolinks="false">second tutorial</a>
    HEREDOC

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'applies the modification to three matching href links' do
    input = <<~HEREDOC
      <a href="/tutorials/one/">first tutorial</a>
      <a href="/tutorials/two/">second tutorial</a>
      <a href="/tutorials/three/">third tutorial</a>
    HEREDOC

    expected_output = <<~HEREDOC
      <a href="/tutorials/one/" data-turbolinks="false">first tutorial</a>
      <a href="/tutorials/two/" data-turbolinks="false">second tutorial</a>
      <a href="/tutorials/three/" data-turbolinks="false">third tutorial</a>
    HEREDOC

    expect(described_class.call(input)).to eql(expected_output)
  end

  it 'applies the modification to only matching links in an array of href links' do
    input = <<~HEREDOC
      <a href="/one/">first tutorial</a>
      <a href="/tutorials/two/">second tutorial</a>
      <a href="/three/">third tutorial</a>
    HEREDOC

    expected_output = <<~HEREDOC
      <a href="/one/">first tutorial</a>
      <a href="/tutorials/two/" data-turbolinks="false">second tutorial</a>
      <a href="/three/">third tutorial</a>
    HEREDOC

    expect(described_class.call(input)).to eql(expected_output)
  end
end
