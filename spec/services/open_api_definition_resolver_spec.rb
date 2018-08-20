require 'rails_helper'

RSpec.describe OpenApiDefinitionResolver do
  describe '#find' do
    context 'when given a definition supplied by nexmo_api_specification dependency' do
      it 'returns a OasParser::Definition' do
        definition = OpenApiDefinitionResolver.find('sms')
        expect(definition).to be_kind_of(OasParser::Definition)
      end
    end

    context 'when given a definition supplied by the project' do
      before do
        fixture_path = 'spec/fixtures/open_api/petstore-multiple-response.yml'
        allow(OpenApiDefinitionResolver).to receive(:path).and_return(fixture_path)
      end

      it 'returns a OasParser::Definition' do
        definition = OpenApiDefinitionResolver.find('petstore-multiple-response')
        expect(definition).to be_kind_of(OasParser::Definition)
      end
    end

    context 'when given an invalid definition' do
      it 'raises an exception' do
        expect do
          OpenApiDefinitionResolver.find('foobar')
        end.to raise_error("Could not find definition 'foobar'")
      end
    end
  end

  describe '#paths' do
    it 'returns paths in the expected order' do
      expect(OpenApiDefinitionResolver.paths('foobar')).to eq([
                                                                '_open_api/definitions/foobar.json',
                                                                '_open_api/definitions/foobar.yaml',
                                                                '_open_api/definitions/foobar.yml',
                                                              ])
    end
  end
end
