require 'rails_helper'

RSpec.describe ParameterValuesHelper, type: :helper do
  describe '#parameter_values' do
    it 'returns a sentence containing the given values wrapped in code tags' do
      expect(helper.parameter_values(%w[value])).to eq('<code>value</code>')
    end

    it 'returns a html_safe string' do
      expect(helper.parameter_values(%w[value])).to be_html_safe
    end

    it 'uses or to connect the last two values in the sentence' do
      expect(helper.parameter_values(%w[1 2])).to eq('<code>1</code> or <code>2</code>')
      expect(helper.parameter_values(%w[1 2 3])).to eq('<code>1</code>, <code>2</code> or <code>3</code>')
    end
  end
end
