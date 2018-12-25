require 'rails_helper'

RSpec.describe LanguageFilter do
    it 'does nothing to text that does not match the regex' do 
        input = 'some text'

        expected_output = 'some text'
        
        expect(described_class.call(input)).to eql(expected_output)
    end

    it 'raises an error if input is whitespace' do 
        input = ' '

        expected_output = ' '

        expect{described_class(input)}.to raise_error(ArgumentError)
    end

    it 'wraps matching input in a span tag and assigns "lang" to the tag' do 
        input = "[נצמו](lang: 'il')"

        expected_output = "<span lang='il'>נצמו</span>"

        expect(described_class.call(input)).to eql(expected_output)
    end

    it 'does nothing if the text is in correct format but it is missing the correct formatting' do 
        input = "Bonjour(lang: 'fr')"

        expected_output = "Bonjour(lang: 'fr')"

        expect(described_class.call(input)).to eql(expected_output)
    end
end