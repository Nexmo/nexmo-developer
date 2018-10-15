require 'rails_helper'

RSpec.describe Nokogiri::HTML::Document do
  context '#split_html' do
    it 'returns an array of split HTML' do
      input = <<~HEREDOC
        <h1>Alpha Heading</h1>
        <p>Alpha content</p>
        <h2>Bravo Heading</h2>
        <p>Bravo content 1</p>
        <p>Bravo content 2</p>
        <h2>Charlie Heading</h2>
        <p>Charlie content 1</p>
        <p>Charlie content 2</p>
      HEREDOC

      document = Nokogiri::HTML(input)
      split_document = document.split_html

      expect(split_document.class).to eq(Array)
      expect(split_document.size).to eq(3)

      expect(split_document[0].class).to eq(Nokogiri::HTML::Document)
      expect(split_document[0].css('body').children.size).to eq(2)

      expect(split_document[0].text).to include('Alpha Heading')
      expect(split_document[0].text).to include('Alpha content')

      expect(split_document[1].text).to include('Bravo Heading')
      expect(split_document[1].text).to include('Bravo content 1')
      expect(split_document[1].text).to include('Bravo content 2')

      expect(split_document[2].text).to include('Charlie Heading')
      expect(split_document[2].text).to include('Charlie content 1')
      expect(split_document[2].text).to include('Charlie content 2')
    end
  end
end
