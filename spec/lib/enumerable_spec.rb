require 'rails_helper'

RSpec.describe Enumerable do
  context '#each_with_position' do
    it 'returns bar' do
      first_string = ''
      last_string = ''

      ['a', 'b', 'c'].each_with_position do |string, first, last|
        first_string = string if first
        last_string = string if last
      end

      expect(first_string).to eq('a')
      expect(last_string).to eq('c')
    end
  end
end
