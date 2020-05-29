require 'rails_helper'

RSpec.describe PageTitle, type: :model do
  let(:product) { nil }

  subject { described_class.new(product, title) }

  describe '#title' do
    context 'with title' do
      let(:title) { 'Metadata Example Title' }

      context 'with product' do
        let(:product) { 'Example Product' }

        it 'returns the product and title with the default appended' do
          expect(subject.title).to eq('Example Product > Metadata Example Title | Vonage API Developer')
        end
      end

      context 'without one' do
        it 'returns the title with the default appended' do
          expect(subject.title).to eq('Metadata Example Title | Vonage API Developer')
        end
      end
    end

    context 'without title' do
      let(:title) { nil }

      it 'returns the default' do
        expect(subject.title).to eq('Vonage API Developer')
      end
    end
  end
end
