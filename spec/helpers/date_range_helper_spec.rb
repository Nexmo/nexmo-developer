require 'rails_helper'

RSpec.describe DateRangeHelper, type: :helper do
  describe '#date_range' do
    context 'when start date and end date are the same' do
      let(:start_date) { Date.new(2016, 12, 7) }
      let(:end_date) { start_date }

      it 'returns the formatted start date' do
        expect(helper.date_range(start_date, end_date)).to eq('7 December 2016')
      end
    end

    context 'when start date and end date are different' do
      let(:start_date) { Date.new(2020, 3, 4) }
      let(:end_date) { Date.new(2020, 3, 5) }

      it 'returns the formatted start date and end date' do
        expect(helper.date_range(start_date, end_date)).to eq('4 March 2020 - 5 March 2020')
      end
    end
  end
end
